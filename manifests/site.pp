## site.pp ##
# Disable filebucket by default for all File resources:
File { backup => false }

# Randomize enforcement order to help understand relationships
ini_setting { 'random ordering':
  ensure  => present,
  path    => "${settings::confdir}/puppet.conf",
  section => 'agent',
  setting => 'ordering',
  value   => 'title-hash',
}

# DEFAULT NODE
# Node definitions in this file are merged with node data from the console. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.

node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
  notify { hiera('message'): }
  
  if $::virtual != 'physical' {
    $virtualname = capitalize($::virtual)
    notify {"This is a ${virtualname} virtual machine, with a capitalized name.":}
  }
  
  exec { "cowsay 'Welcome to ${::fqdn}!' > /etc/motd":
    creates => '/etc/motd',
    path => '/usr/local/bin'
}

  host { 'hosinfefer2002.puppetlabs.vm':
    ensure       => present,
    ip           => '127.0.0.1',
    host_aliases => 'hosinfefer2002',
  }
  notify { "Greetings, this server's name is ${::hostname}": }
  include examples::fundamentals
  include users
  include skeleton
  include memcached
  include nginx
  include aliases
  include wrappers
}
