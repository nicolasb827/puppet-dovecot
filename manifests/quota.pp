class dovecot::quota (
  # 90-quota.conf
  $quota          = undef,
  $quota_warnings = [],
  $quota_enabled  = false,
  $template       = 'dovecot/conf.d/90-quota.conf.erb') {
  validate_bool($quota_enabled)

  file { "${dovecot::directory}/conf.d/90-quota.conf":
    content => template($template),
    notify  => Service['dovecot'];
  }
}
