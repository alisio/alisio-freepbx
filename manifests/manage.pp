# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include freepbx::manage
class freepbx::manage {
  service {'mariadb':
    ensure => running,
    enable => true,
  }
  service {'httpd':
    ensure => running,
    enable => true,
  }
  service {'asterisk':
    ensure => running,
    enable => true,
  }
}
