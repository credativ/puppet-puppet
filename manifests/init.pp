class puppet {
  $provisioning_host = hiera('provisioning_host')

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


  file { '/etc/puppet/auth.conf':
    ensure  => present,
    content => template('puppet/auth.conf.erb'),
  }

  file { '/etc/puppet/namespaceauth.conf':
    ensure  => present,
    content => template('puppet/namespaceauth.conf.erb'),
  }
}
