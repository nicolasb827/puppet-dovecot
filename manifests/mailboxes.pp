class dovecot::mailboxes ($template = 'dovecot/conf.d/15-mailboxes.conf.epp') {
  file { "${dovecot::directory}/conf.d/15-mailboxes.conf":
    content => epp($template, {
    }
    ),
    notify  => Service['dovecot'];
  }
}
