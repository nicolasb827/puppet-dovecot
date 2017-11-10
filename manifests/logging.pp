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
  validate_string($log_path)
  validate_string($log_timestamp)
  validate_string($auth_verbose)
  validate_string($auth_debug)
  validate_string($mail_debug)

  file { "${dovecot::directory}/conf.d/10-logging.conf":
    content => epp($template, {
      'log_path'     => $info_log_path,
      'log_facility' => $log_facility,
    }
    ),
    notify  => Service['dovecot'];
  }
}
