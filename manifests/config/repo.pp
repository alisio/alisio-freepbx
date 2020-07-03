# @summary A short summary of the purpose of this defined type.
define freepbx::config::repo (
  $enable  = true,
  $timeout = 120,
  $repo    = $title,
) {
  if $enable{
    exec { "Enable FreePBX repo ${repo}" :
      command => "/usr/sbin/fwconsole ma enablerepo ${repo}",
      timeout => $timeout,
      require => Exec["Config FreePBX ${freepbx::freepbx_version}"],
      notify  => Exec['Set FreePBX file permission']
    }
  } else {
    exec { "Disable FreePBX repo ${repo}" :
      command => "/usr/sbin/fwconsole ma disablerepo ${repo}",
      timeout => $timeout,
      require => Exec["Config FreePBX ${freepbx::freepbx_version}"],
      notify  => Exec['Set FreePBX file permission']
    }
  }
}
