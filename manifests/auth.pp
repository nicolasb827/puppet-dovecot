class dovecot::auth (
  # 10-auth.conf
  $disable_plaintext_auth     = undef,
  $auth_username_chars        = undef,
  $auth_username_format       = undef,
  $auth_mechanisms            = ['plain'],
  $auth_include               = ['system'],
  $auth_master_user_separator = '*',
  $auth_verbose               = undef,
  $auth_debug                 = undef,
  $auth_debug_passwords       = undef,
  $template                   = 'dovecot/conf.d/10-auth.conf.epp') {
  # 10-auth.conf
  validate_legacy('Optional[Boolean]', 'validate_bool', $disable_plaintext_auth)
  validate_legacy('Optional[Boolean]', 'validate_bool', $auth_verbose)
  validate_legacy('Optional[Boolean]', 'validate_bool', $auth_debug)
  validate_legacy('Optional[Boolean]', 'validate_bool', $auth_debug_passwords)
  validate_legacy('Optional[String]', 'validate_string', $auth_username_chars)
  validate_legacy('Optional[String]', 'validate_string', $auth_master_user_separator)
  validate_legacy('Optional[String]', 'validate_string', $auth_username_format)
  validate_legacy('Optional[Array[String]]', 'is_array', $auth_include)
  validate_legacy('Optional[Array[String]]', 'is_array', $auth_mechanisms)

  validate_legacy('String', 'validate_string', $template)

  file { "${dovecot::directory}/conf.d/10-auth.conf":
    content => epp($template, {
      disable_plaintext_auth     => $disable_plaintext_auth,
      auth_verbose               => $auth_verbose,
      auth_debug                 => $auth_debug,
      auth_debug_passwords       => $auth_debug_passwords,
      auth_username_chars        => $auth_username_chars,
      auth_username_format       => $auth_username_format,
      auth_master_user_separator => $auth_master_user_separator,
      auth_mechanisms            => $auth_mechanisms,
      auth_include               => $auth_include,
    }
    ),
    notify  => Service['dovecot'];
  }
}
