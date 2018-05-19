# linuxgsm
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include linuxgsm
class linuxgsm (
  String $install_dir,
  Array[String] $packages,
  Boolean $add_multiarch,
) {

  contain linuxgsm::install

}
