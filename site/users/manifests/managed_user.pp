define users::managed_user (
  $manageduser = $newuser,
  ){
  user { $newuser:
    ensure => present
  }
  file {"/home/${newuser}":
    ensure => directory,
    owner => $title,
    group => $group,
    mode => '0755'
  }
}
