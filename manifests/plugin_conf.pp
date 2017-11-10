class dovecot::plugin_conf (
  # 90-plugin.conf
  $fts      = undef,
  $template = 'dovecot/conf.d/90-plugin.conf.epp') {
  file { "${dovecot::directory}/conf.d/90-plugin.conf":
    content => template($template),
    notify  => Service['dovecot'];
  }
}
