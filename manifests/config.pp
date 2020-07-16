# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include freepbx::config
class freepbx::config inherits freepbx {
  class {'selinux':
    mode => $freepbx::selinux_mode,
    type => $freepbx::selinux_type,
  }
  augeas { 'configure_php':
    context =>  '/files/etc/php.ini/PHP',
    changes =>  ["set upload_max_filesize ${freepbx::params::php_upload_maxsize}M"],
  }
  augeas { 'configure_php_memory_limit':
    context =>  '/files/etc/php.ini/PHP',
    changes =>  ["set memory_limit ${freepbx::params::php_set_memory_limit}M"],
  }
  augeas { 'Set asterisk runuser':
    context =>  '/files/etc/php.ini/PHP',
    changes =>  ["set upload_max_filesize ${freepbx::params::php_upload_maxsize}M"],
  }
  file { 'Asterisk config file':
    ensure  => file,
    path    => '/etc/asterisk/asterisk.conf',
    mode    => '0644',
    content => template('freepbx/etc/asterisk/asterisk.conf.erb'),
    notify  => Service['asterisk'],
  }
  augeas { 'set apache user/group':
    context => '/files/etc/httpd/conf/httpd.conf',
    changes => [
      'set directive[.="User"] "User"',
      'set directive[.="User"]/arg "asterisk"',
      'set directive[.="Group"] "Group"',
      'set directive[.="Group"]/arg "asterisk"',
      'set directive[.="Group"] "Group"',
      'set directive[.="Group"]/arg "asterisk"',
    ],
    notify  => Service['httpd'],
  }
  exec { 'set apache allowoverride':
    command => 'sed -i "s/[Aa]llow[Oo]verride [Nn]one/AllowOverride All/" /etc/httpd/conf/httpd.conf',
    onlyif  => 'egrep -q -i "AllowOverride None" /etc/httpd/conf/httpd.conf',
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    notify  => Service['httpd'],
  }
}
