class dovecot::pop3 (
  # 20-pop3.conf
  $pop3_mail_plugins       = undef,
  $pop3_uidl_format        = undef,
  $pop3_client_workarounds = undef,
  $template                = 'dovecot/conf.d/20-pop3.conf.erb') {
  file { "${dovecot::directory}/conf.d/20-pop3.conf":
    content => template($template),
    notify  => Service['dovecot'];
  }
}
