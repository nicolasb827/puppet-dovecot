class dovecot::lda (
    # 15-lda.conf
    $postmaster_address           = undef,
    $hostname                     = undef,
    $lda_mail_plugins             = undef,
    $lda_mail_location            = undef,
    $lda_mailbox_autocreate       = undef,
    $lda_mailbox_autosubscribe    = undef,
) {

    # 15-lda.conf
    validate_string($postmaster_address)
    validate_string($hostname)
    validate_string($lda_mail_plugins)

    file { "${dovecot::directory}/conf.d/15-lda.conf":
        content => template('dovecot/conf.d/15-lda.conf.erb'),
        notify  => Service['dovecot'];
    }
}
