class dovecot::replicator (
    $options_plugins              = {},
) {

    validate_hash($options_plugins)
    validate_hash($options_plugins[replication])
    validate_string($options_plugins[replication][mail_replica])
    validate_string($options_plugins[replication][dsync_remote_cmd])
    validate_string($options_plugins[replication][replication_full_sync_interval])
    validate_string($options_plugins[replication][replication_dsync_parameters])

    file { "${dovecot::directory}/conf.d/99-replicator.conf":
        content => template('dovecot/conf.d/99-replicator.conf.erb'),
        notify  => Service['dovecot'];
    }
}
