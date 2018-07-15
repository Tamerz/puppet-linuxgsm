# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include linuxgsm::rust
class linuxgsm::rust (
  String $user,
  String $install_dir,
  Integer $port,
  Array[String] $packages,
) inherits linuxgsm {

  user { $user:
    ensure => present,
  }

  package { $packages:
    ensure => installed,
  }

  file { $install_dir:
    ensure  => directory,
    owner   => $user,
    group   => $user,
    require => User[$user],
  }

  exec { 'install_rustserver':
    command => '/usr/bin/wget https://linuxgsm.com/dl/linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh rustserver && ./rustserver ai',
    cwd     => $install_dir,
    user    => $user,
    creates => "${install_dir}/rustserver",
    timeout => 0,
  }

  if $linuxgsm::use_firewalld {
    firewalld_port { 'rustserver':
      ensure   => present,
      zone     => 'public',
      port     => $port,
      protocol => 'udp',
    }
  }

}
