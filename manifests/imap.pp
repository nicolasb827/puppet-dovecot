class dovecot::imap (
  # 20-imap.conf
  $imap_listen_port        = '*:143',
  $imaps_listen_port       = '*:993',
  $imap_mail_plugins       = undef,
  $imap_client_workarounds = undef,
  $protocol_imap_listen    = true,
  $capability              = undef,
  $template                = 'dovecot/conf.d/20-imap.conf.epp') {
  validate_string($imap_mail_plugins)

  file { "${dovecot::directory}/conf.d/20-imap.conf":
    content => epp($template, {
    }
    ),
    notify  => Service['dovecot'];
  }
}
