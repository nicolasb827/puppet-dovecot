class dovecot::mailboxes (
) {

    file { "${dovecot::directory}/conf.d/15-mailboxes.conf":
        content => template('dovecot/conf.d/15-mailboxes.conf.erb'),
    }
}
