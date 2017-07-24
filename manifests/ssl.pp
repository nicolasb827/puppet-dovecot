class dovecot::ssl (
    # 10-ssl.conf
    $ssl                          = undef,
    $ssl_cert                     = '/etc/pki/dovecot/certs/dovecot.pem',
    $ssl_key                      = '/etc/pki/dovecot/private/dovecot.pem',
    $ssl_cipher_list              = undef,
    $ssl_protocols                = undef,
    $ssl_dh_parameters_length     = undef,
) {

    # 10-ssl.conf
    validate_string($ssl)
    validate_string($ssl_cert)
    validate_string($ssl_key)
    validate_string($ssl_key)

    file { "${dovecot::directory}/conf.d/10-ssl.conf":
        content => template('dovecot/conf.d/10-ssl.conf.erb'),
    }
}
