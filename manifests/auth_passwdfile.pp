class dovecot::auth_passwdfile (
    # auth-passwdfile.conf.ext
    $passdb       = undef,
    $userdb       = undef,
) {

    file { "${dovecot::directory}/conf.d/auth-passwdfile.conf.ext" :
        content => template('dovecot/conf.d/auth-passwdfile.conf.ext.erb'),
        notify => Service['dovecot'];
    }
}
