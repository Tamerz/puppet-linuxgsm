# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include linuxgsm::minecraft
class linuxgsm::minecraft (
  String $java_package,
  String $install_dir,
  String $user,
  Integer $port,
) inherits linuxgsm {

  package { $java_package: }

  user { $user:
    ensure => present,
  }

  file { $install_dir:
    ensure  => directory,
    owner   => $user,
    group   => $user,
    require => User[$user],
  }

  exec { 'install_mcserver':
    command => '/usr/bin/wget https://linuxgsm.com/dl/linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh mcserver && ./mcserver ai',
    cwd     => $install_dir,
    user    => $user,
    creates => "${install_dir}/mcserver",
    timeout => 0,
  }

  if $linuxgsm::use_firewalld {
    firewalld_port { 'minecraft':
      ensure   => present,
      zone     => 'public',
      port     => $port,
      protocol => 'tcp',
    }
  }

}
