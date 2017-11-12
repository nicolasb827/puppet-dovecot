class dovecot::logging (
  # 10-logging.conf
  $log_path       = undef,
  $log_timestamp  = undef,
  $debug_log_path = undef,
  $info_log_path  = undef,
  $auth_verbose   = undef,
  $auth_debug     = undef,
  $mail_debug     = undef,
  $log_facility   = "mail",
  $template       = 'dovecot/conf.d/10-logging.conf.epp') {
  # 10-logging.conf

  validate_legacy('Optional[String]', 'validate_string', $log_path)
  validate_legacy('Optional[String]', 'validate_string', $debug_log_path)
  validate_legacy('Optional[String]', 'validate_string', $log_timestamp)
  validate_legacy('String', 'validate_string', $log_facility)
  validate_legacy('Optional[Boolean]', 'validate_bool', $auth_verbose)
  validate_legacy('Optional[Boolean]', 'validate_bool', $auth_debug)
  validate_legacy('Optional[Boolean]', 'validate_bool', $mail_debug)

  file { "${dovecot::directory}/conf.d/10-logging.conf":
    content => epp($template, {
      log_path       => $info_log_path,
      info_log_path  => $info_log_path,
      debug_log_path => $debug_log_path,
      log_timestamp  => $log_timestamp,
      log_facility   => $log_facility,
      auth_verbose   => $auth_verbose,
      auth_debug     => $auth_debug,
      mail_debug     => $mail_debug,
    }
    ),
    notify  => Service['dovecot'];
  }
}
