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
  $.eppose_proctitle = undef,
  $shutdown_clients  = undef,
  $mail_max_userip_connections = undef,
  $dict_acl          = undef,
  $manage_service    = true,
  $custom_packages   = undef,
  $ensure_packages   = 'installed',) {
  validate_integer($version)
  validate_array($plugins)
  # dovecot.conf
  validate_string($protocols)
  validate_string($listen)
  validate_string($login_greeting)
  validate_string($login_trusted_networks)
  validate_string($.eppose_proctitle)
  validate_string($shutdown_clients)

  if $custom_packages == undef {
    case $::operatingsystem {
      'RedHat', 'CentOS' : {
        $packages = ['dovecot', 'dovecot-pigeonhole']
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
    }
    ),
  }
}
