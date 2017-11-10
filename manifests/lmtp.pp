class dovecot::lmtp (
  # 20-lmtp.conf
  $lmtp_mail_plugins           = undef,
  $lmtp_save_to_detail_mailbox = undef,
  $template                    = 'dovecot/conf.d/20-lmtp.conf.epp') {
  # 20-lmtp.conf
  validate_string($lmtp_mail_plugins)

  file { "${dovecot::directory}/conf.d/20-lmtp.conf":
    content => epp($template, {
    }
    ),
    notify  => Service['dovecot'];
  }
}
