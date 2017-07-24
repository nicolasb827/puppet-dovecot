class dovecot::auth_passwdfile (
    # auth-passwdfile.conf.ext
    $auth_passwdfile_passdb       = undef,
    $auth_passwdfile_userdb       = undef,
) {

    file { "${dovecot::directory}/conf.d/auth-passwdfile.conf.ext" :
        content => template('dovecot/conf.d/auth-passwdfile.conf.ext.erb'),
    }
}
