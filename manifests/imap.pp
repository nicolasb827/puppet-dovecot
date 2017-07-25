class dovecot::imap (
    # 20-imap.conf
    $imap_listen_port             = '*:143',
    $imaps_listen_port            = '*:993',
    $imap_mail_plugins            = undef,
    $imap_client_workarounds      = undef,
    $protocol_imap_listen         = true,
    $capability                   = 'IMAP4rev1 UNSELECT ID CHILDREN NAMESPACE IDLE UIDPLUS',
) {

    validate_string($imap_mail_plugins)

    file { "${dovecot::directory}/conf.d/20-imap.conf":
        content => template('dovecot/conf.d/20-imap.conf.erb'),
    }
}
