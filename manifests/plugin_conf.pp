class dovecot::plugin_conf (
    # 90-plugin.conf
    $fts                          = undef,

) {


    file { "${dovecot::directory}/conf.d/90-plugin.conf":
        content => template('dovecot/conf.d/90-plugin.conf.erb'),
    }

}
