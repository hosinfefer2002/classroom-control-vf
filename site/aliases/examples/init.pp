user { 'administrator':
  ensure => present,
}

class { 'aliases':
  admin   => 'administrator',
  require => User['administrator'],
}

