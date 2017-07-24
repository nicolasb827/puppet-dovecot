class dovecot::sieve (
    # 90-sieve.conf
    $sieve                        = '~/.dovecot.sieve',
    $sieve_after                  = undef,
    $sieve_before                 = undef,
    $sieve_dir                    = '~/sieve',
    $sieve_global_dir             = undef,
    $sieve_max_actions            = undef,
    $sieve_max_redirects          = undef,
    $sieve_max_script_size        = undef,
    $sieve_quota_max_scripts      = undef,
    $sieve_quota_max_storage      = undef,
    $sieve_extensions             = undef,
    $recipient_delimiter          = undef,
) {

    # 90-sieve.conf
    validate_string($sieve)
    validate_string($sieve_dir)
    validate_string($sieve_extensions)
    validate_string($recipient_delimiter)

    file { "${dovecot::directory}/conf.d/90-sieve.conf":
        content => template('dovecot/conf.d/90-sieve.conf.erb'),
    }

}
