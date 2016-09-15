file { '/etc/puppetlabs/code/environments/production/hiera.yaml':
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  source => 'file:///vagrant/manifest/files/hiera.yaml',
}
