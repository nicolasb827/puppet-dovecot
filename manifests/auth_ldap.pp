class dovecot::auth_ldap (
    # auth-ldap.conf.ext
    $auth_ldap_userdb_static      = undef,

    $ldap_uris                    = undef,
    $config                       = {},

) {

    validate_string($ldap_uris)

    file { "${dovecot::directory}/conf.d/auth-ldap.conf.ext":
        content => template('dovecot/conf.d/auth-ldap.conf.ext.erb'),
        notify  => Service['dovecot'];
    }

    if 'ldap' in $dovecot::plugins {
      file { "${dovecot::directory}/dovecot-ldap.conf.ext":
          content => template('dovecot/dovecot-ldap.conf.ext.erb'),
          notify  => Service['dovecot'];
      }
    }
}
