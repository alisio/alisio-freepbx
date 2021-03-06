# @summary Contains the parameter with the default  values
#
# This class holds the parameter with the default  values
#
class freepbx::params {
  $asterisk_install       = true
  $asterisk_default_language = 'pt-br'
  $asterisk_packages      = [
    'asterisk',
    'asterisk-ael',
    'asterisk-iax2',
    'asterisk-fax',
    'asterisk-ldap',
    'asterisk-minivm',
    'asterisk-mp3',
    'asterisk-mysql',
    'asterisk-ooh323',
    'asterisk-oss',
    'asterisk-pjsip',
    'asterisk-sip',
    'asterisk-sounds-core-en-sln16',
    'asterisk-moh-opsound-wav',
    'asterisk-sqlite',
  ]
  $asterisk_verbose       = 3
  $asterisk_version       = 16
  $asterisk_sounds_folder = '/usr/share/asterisk/sounds/'
  $freepbx_modules        = [
    'announcement',
    'soundlang',
    'recordings',
    'backup',
    'blacklist',
    'certman',
    'callforward',
    'callwaiting',
    'callback',
    'callrecording',
    # 'campon',
    'cdr',
    'conferences',
    'customappsreg',
    'customcontexts',
    'donotdisturb',
    'dundicheck',
    'endpointman',
    'featurecodeadmin',
    'userman',
    'fax',
    'findmefollow',
    'hotelwakeup',
    'iaxsettings',
    'ivr',
    'infoservices',
    'logfiles',
    'manager',
    'miscapps',
    'miscdests',
    'music',
    'paging',
    'parking',
    'pinsets',
    'presencestate',
    'phonebook',
    'printextensions',
    'queues',
    'queueprio',
    'restapi',
    'ringgroups',
    'setcid',
    'speeddial',
    'timeconditions',
    'ttsengines',
    'tts',
    'webrtc',
  ]
  $freepbx_module_repo           = [
    'extended',
    'standard',
    'unsupported'
  ]
  $freepbx_version        = '14.0'
  $selinux_mode           = 'disabled'
  $selinux_type           = 'targeted'
  $freepbx_groups_deps    = ['Development Tools']
  $freepbx_package_deps   = [
    'lynx','tftp-server','unixODBC','mysql-connector-odbc','mariadb-server','mariadb',
    'httpd','ncurses-devel','sendmail','sendmail-cf','sox','newt-devel','libxml2-devel','libtiff-devel',
    'audiofile-devel','gtk2-devel','subversion','kernel-devel','git','crontabs','cronie',
    'cronie-anacron','uuid-devel','sqlite-devel','ngrep','nmap-ncat','net-tools','gnutls-devel','python-devel','texinfo',
    'libuuid-devel','php56w','php56w-pdo','php56w-mysql','php56w-mbstring','php56w-pear',
    'php56w-process','php56w-xml','php56w-opcache','php56w-ldap','php56w-intl','php56w-soap','wget'
  ]
  $package_repo_install   = true
  # Upload maxsize in MB
  $php_set_memory_limit   = 256
  $php_upload_maxsize     = 300
  $reboot_after_install   = false
}
