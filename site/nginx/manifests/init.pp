class nginx (
$root = undef,
) {
  case $::osfamily {
    'Redhat':{
      $package    = 'nginx'
      $owner      = 'root'
      $group      = 'root'
      #$nginx_root = '/var/www'
      $def_docroot = '/var/www'
      $conf_dir   = '/etc/nginx'
      $sblock_dir = '/etc/nginx/conf.d'
      $log_dir    = '/var/log/nginx'
      $user       = 'nginx'
    }
    'Debian':{
      $package    = 'nginx'
      $owner      = 'root'
      $group      = 'root'
      $nginx_root = '/var/www'
      $conf_dir   = '/etc/nginx'
      $sblock_dir = '/etc/nginx/conf.d'
      $log_dir    = '/var/log/nginx'
      $user       = 'www-data'
    }
    'Windows':{
      $package    = 'nginx-service'
      $owner      = 'Administrator'
      $group      = 'Administrators'
      $nginx_root = 'C:/ProgramData/nginx/html'
      $conf_dir   = 'C:/ProgramData/nginx'
      $sblock_dir = 'C:/ProgramData/nginx/conf.d'
      $log_dir    = 'C:/ProgramData/nginx/logs'
      $user       = 'nobody'
    }
  }
  
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
