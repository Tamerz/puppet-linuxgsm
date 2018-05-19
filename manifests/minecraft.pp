# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include linuxgsm::minecraft
class linuxgsm::minecraft (
  String $java_package,
) {

  package { $java_package: }

}
