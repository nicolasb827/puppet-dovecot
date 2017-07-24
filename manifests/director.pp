class dovecot::director (
) {

    file { "${dovecot::directory}/conf.d/10-director.conf":
        content => template('dovecot/conf.d/10-director.conf.erb'),
    }
}
