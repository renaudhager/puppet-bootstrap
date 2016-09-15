# Boostrap node with puppet

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

exec{ 'r10k':
  command => '/opt/puppetlabs/puppet/bin/r10k deploy environment --puppetfile',
  require => [
    Exec['rmproduction'],
    File['/etc/puppetlabs/r10k/r10k.yaml']
  ]
}

# Remove production original dir
exec { 'rmproduction':
  command => '/bin/rm -rf /etc/puppetlabs/code/environments/production',
}

# # Install git
# package { 'git':
#   ensure => 'present',
# }

# package { 'librarian-puppet':
#   ensure   => 'present',
#   provider => 'gem',
# }





# Git clone of puppet code
# exec { 'gitclone':
#   command => '/usr/bin/git clone https://github.com/renaudhager/puppet-masterless.git /etc/puppetlabs/code/environments/production',
#   require => [
#     Package['git'],
#     Exec['rmproduction'],
#   ],
# }

# exec { 'installmodule':
#   command => '/usr/local/bin/librarian-puppet install',
#   requied => Exec['gitclone'],
#
# }
