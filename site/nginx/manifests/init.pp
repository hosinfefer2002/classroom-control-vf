class nginx (
$root        = undef,
$package     = $nginx::params::package,
$owner       = $nginx::params::owner,
$group       = $nginx::params::group,
$def_docroot = $nginx::params::def_docroot,
$conf_dir    = $nginx::params::conf_dir,
$sblock_dir  = $nginx::params::sblock_dir,
$log_dir     = $nginx::params::log_dir,
$user        = $nginx::params::user,
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
  
  package { '$package':
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
