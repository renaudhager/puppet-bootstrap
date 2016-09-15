# Boostrap node with puppet

# Setup hiera file
file { '/etc/puppetlabs/code/hiera.yaml':
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  source => 'file:///tmp/puppet-bootstrap/files/hiera.yaml',
}

# Install git
package { 'git':
  ensure => 'present',
}

# Git clone of puppet code
exec { 'gitclone':
  command => 'git clone https://github.com/renaudhager/puppet-masterless.git /etc/puppetlabs/code/environments/production',
  require => Package['git'],
}
