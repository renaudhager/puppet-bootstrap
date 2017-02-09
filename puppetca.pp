# Boostrap a puppet ca node

# Remove production original dir
exec { 'rmproduction':
  command => '/bin/rm -rf /etc/puppetlabs/code/environments/production',
}

# Setup hiera file
file { '/etc/puppetlabs/code/hiera.yaml':
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  source => 'file:///tmp/puppet-bootstrap/files/hiera.yaml',
}

# Install r10k
file { '/etc/puppetlabs/r10k':
  ensure => 'directory',
  owner  => 'root',
  group  => 'root',
  mode   => '0755',
}
file { '/etc/puppetlabs/r10k/r10k.yaml':
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  source  => 'file:///tmp/puppet-bootstrap/files/r10k.yaml',
  require => File['/etc/puppetlabs/r10k'],
}

exec {'r10k_installation':
  command => '/opt/puppetlabs/puppet/bin/gem install r10k',
}

exec{ 'r10k':
  command => '/opt/puppetlabs/puppet/bin/r10k deploy environment --puppetfile -v',
  require => [
    Exec['rmproduction', 'r10k_installation'],
    File['/etc/puppetlabs/r10k/r10k.yaml']
  ]
}
