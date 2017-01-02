# Dovecot

[![Build Status](https://travis-ci.org/lvicainne/puppet-dovecot.svg?branch=master)](https://travis-ci.org/lvicainne/puppet-dovecot)

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with BashRC](#setup)
    * [What dovecot module affects](#what-dovecot-module-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with dovecot](#beginning-with-dovecot)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

This module works under RedHat, CentOS 6+, Ubuntu 12+ and FreeBSD.
This module configures a Dovecot server (2.x and later)

It is a fork from [mxHero](https://github.com/mxhero/puppet-dovecot)

## Setup

### What Dovecot module affects

* Modify the files linked to dovecot (usually in /etc/dovecot) using the conf.d structure adopted by Dovecot 2.x.
* Install all the packages linked to Dovecot IMAP server.
* This module make also working managesieve.

### Beginning with Dovecot

A basic example is as follows:

```puppet
  include ::dovecot
```

## Usage 

* `dovecot` : Main class
* `dovecot::file` : Definition to manage configuration file snippets
* `dovecot::plugin` : Definition to install plugin sub-packages

This module is fully Hiera compliant : you can define your module data only in Hiera.

Example Configuration
---------------------

    class { 'dovecot':
        plugins                    => [ 'mysql', 'pigeonhole' ],
        protocols                  => 'imap pop3 sieve',
        verbose_proctitle          => 'yes',
        auth_include               => 'sql',
        mail_location              => 'maildir:~/Maildir',
        auth_listener_userdb_mode  => '0660',
        auth_listener_userdb_group => 'vmail',
        auth_listener_postfix      => true,
        ssl_cert                   => '/etc/pki/tls/certs/wildcard.example.com.crt',
        ssl_key                    => '/etc/pki/tls/private/wildcard.example.com.key',
        postmaster_address         => 'postmaster@example.com',
        hostname                   => 'mail.example.com',
        lda_mail_plugins           => '$mail_plugins sieve',
        auth_sql_userdb_static     => 'uid=vmail gid=vmail home=/home/vmail/%d/%n',
        log_timestamp              => '"%Y-%m-%d %H:%M:%S "',
    }

    dovecot::file { 'dovecot-sql.conf.ext':
        source => 'puppet:///modules/example/dovecot-sql.conf.ext',
    }

## Limitations

This module has only been tested on my Debian and Centos servers. I can not guarantee for any other Operating System

## Development

I chose to open mu own Dovecot Module ; but you are free to contribute on it, etc.

## Release Notes/Contributors/Etc. 

It is a fork from [mxHero](https://github.com/mxhero/puppet-dovecot)
