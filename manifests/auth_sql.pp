class dovecot::auth_sql (
    # auth-sql.conf.ext
    $auth_sql_userdb_static       = undef,
    $auth_sql_path                = '/etc/dovecot/dovecot-sql.conf.ext',

) {

    file { "${dovecot::directory}/conf.d/auth-sql.conf.ext" :
        content => template('dovecot/conf.d/auth-sql.conf.ext.erb'),
    }
}
