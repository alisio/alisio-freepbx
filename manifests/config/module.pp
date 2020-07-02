# @summary A short summary of the purpose of this defined type.
define freepbx::config::module (
  $ensure  = 'present',
  $timeout = 120,
  $module  = $title,
) {
  if $ensure == 'present' {
    exec { "Install FreePBX ${module} module" :
      command => "/usr/sbin/fwconsole ma downloadinstall ${module};/usr/sbin/fwconsole ma enable ${module}",
      unless  => "/usr/sbin/fwconsole ma list | egrep -q ${module}.*Enabled",
      timeout => $timeout,
      require => Exec["Config FreePBX ${freepbx::freepbx_version}"],
    }
  } else {
    exec { "Disable FreePBX ${module} module" :
      command => "/usr/sbin/fwconsole ma disable ${module}",
      unless  => "/usr/sbin/fwconsole ma list | egrep -q ${module}.*Disabled",
      timeout => $timeout,
      require => Exec["Config FreePBX ${freepbx::freepbx_version}"],
    }
  }
}
