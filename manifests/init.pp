# Class: dovecot
#
# Install, enable and configure the Dovecot IMAP server.
# Options:
#  $plugins:
#    Array of plugin sub-packages to install. Default: empty
#
class dovecot (
  # Version of Dovecot : currently suported : 1 or 2
  # Used to limit the warnings for new format of dovecot.conf
  $version           = 2,
  $plugins           = [],
  # dovecot.conf
  $protocols         = undef,
  $listen            = undef,
  $login_greeting    = undef,
  $login_trusted_networks      = undef,
  $verbose_proctitle = undef,
  $shutdown_clients  = undef,
  $mail_max_userip_connections = undef,
  $dict_acl          = undef,
  $manage_service    = true,
  $custom_packages   = undef,
  $ensure_packages   = 'installed',) {
  validate_integer($version)
  validate_array($plugins)
  # dovecot.conf
  validate_legacy('Optional[Array[String]]', 'is_array', $protocols)
  validate_legacy('Optional[String]', 'validate_string', $listen)
  validate_legacy('Optional[String]', 'validate_string', $login_greeting)
  validate_legacy('Optional[Array[String]]', 'is_array', $login_trusted_networks)
  validate_legacy('Optional[Boolean]', 'validate_string', $verbose_proctitle)
  validate_legacy('Optional[Boolean]', 'validate_string', $shutdown_clients)

  if $custom_packages == undef {
    case $::operatingsystem {
      'RedHat', 'CentOS' : {
        $packages = ['dovecot', 'dovecot-pigeonhole']
        dovecot-pigeonhole
      }
      'Debian', 'Ubuntu' : {
        $packages = [
          'dovecot-core',
          'dovecot-imapd',
          'dovecot-pop3d',
          'dovecot-managesieved',
          'dovecot-mysql',
          'dovecot-ldap',
          'dovecot-lmtpd']
      }
      'FreeBSD'          : {
        $packages = 'mail/dovecot2'
      }
      default            : {
        fail("OS ${::operatingsystem} and version ${::operatingsystemrelease} is not supported.")
      }
    }
  } else {
    $packages = $custom_packages
  }

  case $::operatingsystem {
    'RedHat', 'CentOS'  : {
      $directory = '/etc/dovecot'
      $prefix = 'dovecot'
    }
    /^(Debian|Ubuntu)$/ : {
      $directory = '/etc/dovecot'
      $prefix = 'dovecot'
    }
    'FreeBSD'           : {
      $directory = '/usr/local/etc/dovecot'
      $prefix = 'mail/dovecot2'
    }
    default             : {
      fail("OS ${::operatingsystem} and version ${::operatingsystemrelease} is not supported")
    }
  }

  # All files in this scope are dovecot configuration files
  if $manage_service {
    File {
      notify  => Service['dovecot'],
      require => Package[$packages],
    }
  } else {
    File {
      require => Package[$packages], }
  }

  # Install plugins (sub-packages)
  dovecot::plugin { $plugins:
    before => Package[$packages],
    prefix => $prefix
  }

  # Main package and service it provides
  package { $packages: ensure => $ensure_packages }

  if $manage_service {
    service { 'dovecot':
      ensure    => running,
      enable    => true,
      hasstatus => true,
      require   => File["${directory}/dovecot.conf"],
    }
  }

  # Main configuration directory
  file { $directory: ensure => 'directory', }

  file { "${directory}/conf.d": ensure => 'directory', }

  # Main configuration file
  file { "${directory}/dovecot.conf":
    content => epp('dovecot/dovecot.conf.epp', {
      directory              => $directory,
      protocols              => $protocols,
      listen                 => $listen,
      login_greeting         => $login_greeting,
      login_trusted_networks => $login_trusted_networks,
      verbose_proctitle      => $verbose_proctitle,
      shutdown_clients       => $shutdown_clients,
      dict_acl               => $dict_acl,
    }
    ),
  }
}
