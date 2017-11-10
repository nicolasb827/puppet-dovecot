class dovecot::acl (
  # 90-acl.conf
  $plugin_acl = undef,
  $plugin_acl_anyone              = undef,
  $plugin_acl_shared_dict         = undef,
  $plugin_acl_defaults_from_inbox = undef,
  $template   = 'dovecot/conf.d/90-acl.conf.epp') {
  file { "${dovecot::directory}/conf.d/90-acl.conf":
    content => epp($template, {
    }
    ),
    notify  => Service['dovecot'];
  }
}
