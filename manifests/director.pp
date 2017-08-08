class dovecot::director (
    # 10-director.conf
    Array $director_servers      = undef,
    Array $director_mail_servers = undef,
    Integer $director_port       = undef,
    $lmtp_proxy                  = no,
    $lmtp_port                   = undef,
    $lmtp_haproxy                = undef,

) {

    file { "${dovecot::directory}/conf.d/10-director.conf":
        content => template('dovecot/conf.d/10-director.conf.erb'),
        notify  => Service['dovecot'];
    }
}
