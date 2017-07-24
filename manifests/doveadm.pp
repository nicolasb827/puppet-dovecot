class dovecot::doveadm (
    # 30-doveadm.conf
    $password     = undef,
    $port         = undef,
    $ssl          = undef,

) {

    # 10-master.conf
    validate_string($password)
    validate_integer($port)

    file { "${dovecot::directory}/conf.d/30-doveadm.conf":
        content => template('dovecot/conf.d/30-doveadm.conf.erb'),
    }

}
