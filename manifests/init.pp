class puppet {
  $provisioning_host = hiera('provisioning_host')

  # pson output breaks sometimes with hiera
  # see http://projects.puppetlabs.com/issues/13212
  # therefore we enforce yaml here. maybe slower, but works
  augeas { 'agent_listener':
    context => '/files/etc/puppet/puppet.conf',
    changes => 'set agent/listen true',
  }

  augeas { 'puppet.conf':
    context => '/files/etc/puppet/puppet.conf',
    changes => 'set agent/preferred_serialization_format yaml',
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
