class dovecot::mailboxes ($template = 'dovecot/conf.d/15-mailboxes.conf.erb') {
  file { "${dovecot::directory}/conf.d/15-mailboxes.conf":
    content => template($template),
    notify  => Service['dovecot'];
  }
}
