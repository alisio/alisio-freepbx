# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include freepbx::postinstall
class freepbx::postinstall inherits freepbx {
  if $freepbx::reboot_after_install {
    exec { "Config FreePBX ${freepbx::freepbx_version}":
      command   => 'cd /usr/src/freepbx/; ./install -n',
      unless    => 'test -f /var/www/html/admin/functions.inc.php',
      path      => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
      logoutput => true,
    }
    ~> exec { 'Reboot and apply SELinux change':
      command     => 'reboot',
      path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
      refreshonly => true,
      require     => Exec["Config FreePBX ${freepbx::freepbx_version}"],
      notify      => Exec['Set FreePBX file permission'],
    }
  } else {
    exec { "Config FreePBX ${freepbx::freepbx_version}":
      command   => 'cd /usr/src/freepbx/; ./install -n',
      notify    => Exec['Set FreePBX file permission'],
      unless    => 'test -f /var/www/html/admin/functions.inc.php',
      path      => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
      logoutput => true,
    }
  }
  exec { 'Set FreePBX file permission':
    command     => '/sbin/fwconsole chown',
    refreshonly => true,
    unless      => 'test -f /var/www/html/admin/functions.inc.php',
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    logoutput   => true,
  }
}
