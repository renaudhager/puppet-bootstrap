file { '/etc/puppetlabs/code/hiera.yaml':
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  source => 'file:///tmp/puppet-bootstrap/files/hiera.yaml',
}
