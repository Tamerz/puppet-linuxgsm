# linuxgsm::install
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include linuxgsm::install
class linuxgsm::install inherits linuxgsm {

  package { $linuxgsm::packages:
    ensure => present,
  }

}
