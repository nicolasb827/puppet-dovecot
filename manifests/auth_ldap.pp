class dovecot::auth_ldap (
  # auth-ldap.conf.ext
  $auth_ldap_userdb_static = undef,
  $ldap_uris               = undef,
  $config                  = {
  }
  ,
  $template_auth_ldap      = 'dovecot/conf.d/auth-ldap.conf.ext.epp',
  $template_dovecot_ldap   = 'dovecot/dovecot-ldap.conf.ext.epp') {
  validate_string($ldap_uris)

  file { "${dovecot::directory}/conf.d/auth-ldap.conf.ext":
    content => epp($template_auth_ldap, {
    }
    ),
    notify  => Service['dovecot'];
  }

  if 'ldap' in $dovecot::plugins {
    file { "${dovecot::directory}/dovecot-ldap.conf.ext":
      content => epp($template_dovecot_ldap, {
      }
      ),
      notify  => Service['dovecot'];
    }
  }
}
