# linuxgsm
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include linuxgsm
class linuxgsm (
  Array[String] $packages,
  Boolean $add_multiarch,
  Boolean $use_firewalld,
) {

  contain linuxgsm::install

}
