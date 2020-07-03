# @summary A short summary of the purpose of this defined type.
define freepbx::config::module (
  $ensure  = 'present',
  $timeout = 120,
  $module  = $title,
) {
  if $ensure == 'present' {
    exec { "Download FreePBX ${module} module" :
      command => "/usr/sbin/fwconsole ma downloadinstall ${module}",
      unless  => "/usr/sbin/fwconsole ma list | egrep -q ${module}",
      timeout => $timeout,
      require => Exec["Config FreePBX ${freepbx::freepbx_version}"],
      notify  => Exec['Set FreePBX file permission']
    }
    -> exec { "Enable FreePBX ${module} module" :
      command => "/usr/sbin/fwconsole ma /usr/sbin/fwconsole ma enable ${module}",
      onlyif  => "/usr/sbin/fwconsole ma list | egrep -q ${module}.*Disabled",
      timeout => $timeout,
      require => Exec["Config FreePBX ${freepbx::freepbx_version}"],
      notify  => Exec['Set FreePBX file permission']
    }
  } else {
    exec { "Disable FreePBX ${module} module" :
      command => "/usr/sbin/fwconsole ma disable ${module}",
      onlyif  => "/usr/sbin/fwconsole ma list | egrep -q ${module}.*Enabled",
      timeout => $timeout,
      require => Exec["Config FreePBX ${freepbx::freepbx_version}"],
      notify  => Exec['Set FreePBX file permission']
    }
  }
}
