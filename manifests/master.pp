class dovecot::master (
  # 10-master.conf
  $default_process_limit        = undef,
  $haproxy_trusted_networks     = undef,
  $default_client_limit         = undef,
  $auth_listener_userdb_mode    = undef,
  $auth_listener_userdb_user    = undef,
  $auth_listener_userdb_group   = undef,
  $auth_listener_postfix        = false,
  $auth_listener_postfix_mode   = undef,
  $auth_listener_postfix_user   = undef,
  $auth_listener_postfix_group  = undef,
  $imap_login_process_limit     = undef,
  $imap_login_client_limit      = undef,
  $imap_login_service_count     = undef,
  $imap_login_process_min_avail = undef,
  $imap_login_vsz_limit         = undef,
  $enable_pop3                  = true,
  $pop3_login_process_limit     = undef,
  $pop3_login_service_count     = undef,
  $pop3_login_process_min_avail = undef,
  $default_vsz_limit            = undef,
  $auth_listener_default_user   = undef,
  $imaplogin_imap_port          = -1,
  Boolean $imap_haproxy                 = false,
  $imaplogin_imaps_port         = -1,
  Boolean $imaps_haproxy                = false,
  $imaplogin_imaps_ssl          = false,
  $lmtp_unix_listener           = undef,
  $lmtp_unix_listener_mode      = undef,
  $lmtp_unix_listener_user      = undef,
  $lmtp_unix_listener_group     = undef,
  $lmtp_socket_group            = undef,
  $lmtp_socket_mode             = undef,
  $lmtp_socket_path             = undef,
  $lmtp_socket_user             = undef,
  $dict_listener_mode           = undef,
  $dict_listener_user           = undef,
  $dict_listener_group          = undef,
  $pop3_process_limit           = undef,
  $pop3_service_count           = undef,
  $imap_process_limit           = undef,
  $imap_service_count           = undef,
  $pop3login_pop3_port          = -1,
  Boolean $pop3_haproxy                 = false,
  $pop3login_pop3s_port         = -1,
  Boolean $pop3s_haproxy                = false,
  $pop3login_pop3s_ssl          = false,
  $template                     = 'dovecot/conf.d/10-master.conf.epp') {
  # 10-master.conf
  validate_string($default_client_limit)
  validate_string($auth_listener_userdb_mode)
  validate_string($auth_listener_userdb_user)
  validate_string($auth_listener_userdb_group)
  validate_bool($auth_listener_postfix)
  validate_string($auth_listener_postfix_mode)
  validate_string($auth_listener_postfix_user)
  validate_string($auth_listener_postfix_group)
  validate_integer($imaplogin_imap_port)
  validate_integer($imaplogin_imaps_port)
  validate_bool($imaplogin_imaps_ssl)
  validate_string($lmtp_unix_listener)
  validate_string($lmtp_unix_listener_mode)
  validate_string($lmtp_unix_listener_user)
  validate_string($lmtp_unix_listener_group)
  validate_integer($pop3login_pop3_port)
  validate_integer($pop3login_pop3s_port)
  validate_bool($pop3login_pop3s_ssl)

  file { "${dovecot::directory}/conf.d/10-master.conf":
    content => epp($template, {
    }
    ),
    notify  => Service['dovecot'];
  }
}
