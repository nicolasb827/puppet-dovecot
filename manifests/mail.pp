class dovecot::mail (
    # 10-mail.conf
    $mail_home                    = undef,
    $mail_fsync                   = undef,
    $mail_location                = undef,
    $mail_uid                     = undef,
    $mail_gid                     = undef,
    $mail_nfs_index               = undef,
    $mail_nfs_storage             = undef,
    $mail_privileged_group        = undef,
    $mail_plugins                 = undef,
    $mmap_disable                 = undef,
    $dotlock_use_excl             = undef,
    $include_inbox_namespace      = undef,
    $include_inbox_namespace_separator = undef,
    $custom_namespaces            = {},
    $first_valid_uid              = false,
    $last_valid_uid               = false,
    $shared_mailboxes             = false,
) {

    validate_bool($shared_mailboxes)

    # 10-mail.conf
    validate_string($mail_home)
    validate_string($mail_location)
    validate_string($mail_uid)
    validate_string($mail_gid)
    validate_string($mail_plugins)

    file { "${dovecot::directory}/conf.d/10-mail.conf":
        content => template('dovecot/conf.d/10-mail.conf.erb'),
    }

}
