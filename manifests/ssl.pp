class dovecot::ssl (
  # 10-ssl.conf
  Boolean $ssl      = true,
  $ssl_cert = undef,
  $ssl_key  = undef,
  $ssl_cipher_list          = undef,
  $ssl_protocols            = undef,
  $ssl_dh_parameters_length = undef,
  $template = 'dovecot/conf.d/10-ssl.conf.erb') {
  file { "${dovecot::directory}/conf.d/10-ssl.conf":
    content => template($template),
    notify  => Service['dovecot'];
  }
}
