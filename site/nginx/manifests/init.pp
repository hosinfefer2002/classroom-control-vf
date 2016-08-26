class nginx (
$root = undef,
) {
  
  $docroot = $root ? {
    default => $root,
    undef => $def_docroot
  }
  
  service { 'nginx':
    ensure => running,
    enable => true,
  }
  
  File {
    owner => $owner,
    group => $group,
    mode  => '0664'
  }
  
  package { $package:
    ensure => present,
  }
  
  file { $def_docroot :
    ensure => directory,
  }
  
  file { "${conf_dir}/nginx.conf" :
    ensure  => file,
    content => template('nginx/nginx.conf.erb'),
    notify  => Service['nginx']
  }
  
  file { "${sblock_dir}/default.conf" :
    ensure  => file,
    content => template ('nginx/default.conf.erb'),
    notify  => Service['nginx']
  }
  
  file { "${def_docroot}/index.html" :
    ensure => file,
    source => 'puppet:///modules/nginx/index.html'
  }
}
