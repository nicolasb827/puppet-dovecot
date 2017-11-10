class dovecot::managesieve (
  # 20-managesieve.conf
  $manage_sieve              = undef,
  $managesieve_service       = false,
  $managesieve_service_count = 0,
  $template                  = 'dovecot/conf.d/20-managesieve.conf.epp') {
  # 20-managesieve.conf
  validate_bool($managesieve_service)
  validate_integer($managesieve_service_count)

  file { "${dovecot::directory}/conf.d/20-managesieve.conf":
    content => epp($template, {
    }
    ),
    notify  => Service['dovecot'];
  }
}
