# linuxgsm::install
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include linuxgsm::install
class linuxgsm::install inherits linuxgsm {

  $packages = lookup('linuxgsm::packages', {merge => 'unique'})

  file { $install_dir:
    ensure => directory,
  }

  if $linuxgsm::add_multiarch {
    exec { 'add_multiarch':
      command => '/usr/bin/dpkg --add-architecture i386 && /usr/bin/apt-get update -q',
      unless  => "/bin/grep 'i386' /var/lib/dpkg/arch",
      before  => Package[$packages],
    }
  }

  package { $packages:
    ensure => present,
  }

}
