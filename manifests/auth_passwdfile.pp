class dovecot::auth_passwdfile (
  # auth-passwdfile.conf.ext
  $passdb   = undef,
  $userdb   = undef,
  $template = 'dovecot/conf.d/auth-passwdfile.conf.ext.erb') {
  file { "${dovecot::directory}/conf.d/auth-passwdfile.conf.ext":
    content => template($template),
    notify  => Service['dovecot'];
  }
}
