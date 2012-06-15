class puppet (
    $provisioning_host = params_lookup('provisioning_host', 'global')
    ) inherits puppet::params {

    # pson output breaks sometimes with hiera
    # see http://projects.puppetlabs.com/issues/13212
    # therefore we enforce yaml here. maybe slower, but works
    augeas { 'puppet.conf':
        context => '/files/etc/puppet/puppet.conf',
        changes => 'set agent/preferred_serialization_format yaml',
    }

    augeas { 'agent_listener':
        context => '/files/etc/puppet/puppet.conf',
        changes => 'set agent/listen true',
    }

    package { 'puppet':
        ensure => '2.7.13-1~bpo60+1'
    }
    package { 'puppet-common':

        ensure => '2.7.13-1~bpo60+1'
    }

    package { 'puppetmaster':
        ensure => '2.7.13-1~bpo60+1'
    }
    package { 'puppetmaster-common':
        ensure => '2.7.13-1~bpo60+1'
    }
   

    file { '/etc/puppet/auth.conf':
        ensure  => present,
        content => template('puppet/auth.conf.erb'),
    }

    file { '/etc/puppet/namespaceauth.conf':
        ensure  => present,
        content => template('puppet/namespaceauth.conf.erb'),
    }
}
