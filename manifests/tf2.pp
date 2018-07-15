# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include linuxgsm::tf2
class linuxgsm::tf2 (
  String $install_dir,
  String $user,
  Integer $port,
) inherits linuxgsm {

  user { $user:
    ensure => present,
  }

  file { $install_dir:
    ensure  => directory,
    owner   => $user,
    group   => $user,
    require => User[$user],
  }
}
