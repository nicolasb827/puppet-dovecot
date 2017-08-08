class dovecot::doveadm (
    # 30-doveadm.conf
    String $password  = undef,
    $proxy_port       = undef,
    $http_port        = undef,
    $ssl              = undef,
    $tcp_port         = undef,
    $protocol_doveadm = undef,

) {

    file { "${dovecot::directory}/conf.d/30-doveadm.conf":
        content => template('dovecot/conf.d/30-doveadm.conf.erb'),
        notify  => Service['dovecot'];
    }
}
