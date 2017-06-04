# Define: dovecot::file
#
# Manage dovecot configuration files under /etc/dovecot/.
#
# Example Usage:
#     dovecot::file { 'dovecot-sql.conf.ext':
#         source => 'puppet:///modules/mymodule/dovecot-sql.conf.ext',
#     }
#
define dovecot::file (
    $owner    = 'root',
    $group    = 'root',
    $mode     = '0644',
    $content  = undef,
    $source   = undef,
    $template = undef,
    $config   = {},
) {
    case $::operatingsystem {
        'FreeBSD': { $directory = '/usr/local/etc/dovecot' }
        default:   { $directory = '/etc/dovecot' }
    }

    if $source and $content {
        fail('dovecot::file: source or content can be provided, but not both')
    }

    if $source and $template {
        fail('dovecot::file: source or template can be provided, but not both')
    }

    if $content and $template {
        fail('dovecot::file: content or template can be provided, but not both')
    }

    if $content {
        $the_content = $content
    } elsif $template {
        $the_content = template($template)
    } else {
        $the_content = undef
    }

    file { "${directory}/${title}":
        owner   => $owner,
        group   => $group,
        mode    => $mode,
        content => $the_content,
        source  => $source,
        require => Package[$dovecot::packages],
        replace => true,
    }
    if $dovecot::manage_service {
        File["/etc/dovecot/${title}"] ~> Service['dovecot']
    }
}
