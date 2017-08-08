class dovecot::lmtp (
    # 20-lmtp.conf
    $lmtp_mail_plugins            = undef,
    $lmtp_save_to_detail_mailbox  = undef,
) {

    # 20-lmtp.conf
    validate_string($lmtp_mail_plugins)

    file { "${dovecot::directory}/conf.d/20-lmtp.conf":
        content => template('dovecot/conf.d/20-lmtp.conf.erb'),
        notify  => Service['dovecot'];
    }
}
