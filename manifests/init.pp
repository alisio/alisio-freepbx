# @summary Freepbx main class
#
# This class installs freepbx and its dependencies
#
# @example
#   include freepbx
class freepbx (
  $asterisk_install          = $freepbx::params::asterisk_install,
  $asterisk_default_language = $freepbx::params::asterisk_default_language,
  $asterisk_verbose          = $freepbx::params::asterisk_verbose,
  $asterisk_packages         = $freepbx::params::asterisk_packages,
  $asterisk_version          = $freepbx::params::asterisk_version,
  $asterisk_sounds_folder    = $freepbx::params::asterisk_sounds_folder,
  $freepbx_groups_deps       = $freepbx::params::freepbx_groups_deps,
  $freepbx_package_deps      = $freepbx::params::freepbx_package_deps,
  $freepbx_repo_install      = $freepbx::params::freepbx_repo_install,
  $freepbx_version           = $freepbx::params::freepbx_version,
  $package_repo_install      = $freepbx::params::package_repo_install,
  $reboot_after_install      = $freepbx::params::reboot_after_install,
  $selinux_mode              = $freepbx::params::selinux_mode,
  $selinux_type              = $freepbx::params::selinux_type,
) inherits freepbx::params {
  contain freepbx::install
  contain freepbx::config
  contain freepbx::manage
  contain freepbx::postinstall
}
