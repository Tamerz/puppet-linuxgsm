# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include linuxgsm::rust
class linuxgsm::rust (
  String $user,
  String $install_dir,
) {

  user { $user: }

  file { $install_dir:
    ensure => directory,
    owner  => $user,
    group  => $user,
  }

}
