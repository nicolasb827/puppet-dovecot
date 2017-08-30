class dovecot::doveadm (
  # 30-doveadm.conf
  String $password         = undef,
  $proxy_port       = undef,
  $http_port        = undef,
  $ssl              = undef,
  $tcp_port         = undef,
  $protocol_doveadm = undef,
  $template         = 'dovecot/conf.d/30-doveadm.conf.erb') {
  file { "${dovecot::directory}/conf.d/30-doveadm.conf":
    content => template(),
    notify  => Service['dovecot'];
  }
}
