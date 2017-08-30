class dovecot::auth (
  # 10-auth.conf
  $disable_plaintext_auth     = undef,
  $auth_username_chars        = undef,
  $auth_username_format       = undef,
  $auth_mechanisms            = 'plain',
  $auth_include               = ['system'],
  $auth_master_user_separator = '*',
  $auth_verbose               = undef,
  $auth_debug                 = undef,
  $auth_debug_passwords       = undef,
  $template                   = 'dovecot/conf.d/10-auth.conf.erb') {
  # 10-auth.conf
  validate_bool($disable_plaintext_auth)
  validate_string($auth_username_chars)
  validate_string($auth_username_format)
  validate_string($auth_mechanisms)
  validate_array($auth_include)
  validate_string($auth_master_user_separator)

  file { "${dovecot::directory}/conf.d/10-auth.conf":
    content => template($template),
    notify  => Service['dovecot'];
  }
}
