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
