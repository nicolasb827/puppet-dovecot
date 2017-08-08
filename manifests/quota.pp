class dovecot::quota (
    # 90-quota.conf
    $quota                        = undef,
    $quota_warnings               = [],

    $quota_enabled                = false,

) {

    validate_bool($quota_enabled)

    file { "${dovecot::directory}/conf.d/90-quota.conf":
        content => template('dovecot/conf.d/90-quota.conf.erb'),
        notify  => Service['dovecot'];
    }
}
