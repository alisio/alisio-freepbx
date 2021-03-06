# The baseline for module testing used by Puppet Labs is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation
# errors and view a log of events) or by fully applying the test in a virtual
# environment (to compare the resulting system state to the desired state).
#
# Learn more about module testing here:
# http://docs.puppetlabs.com/guides/tests_smoke.html
#
yumrepo { 'irontec':
  baseurl  => 'http://packages.irontec.com/centos/$releasever/$basearch/',
  descr    => 'Irontec repo for sngrep',
  enabled  => '1',
  gpgcheck => '0',
}
-> package { [
    'augeas',
    'mlocate',
    'sngrep',
    'vim',
  ]:
  ensure => installed,
}
class {'freepbx':
  reboot_after_install => false,
}
-> archive { 'Add portuguese audio prompts':
  ensure           => present,
  path             => '/usr/src/asterisk-sounds-core-pt-BR-sln16.zip',
  source           => 'https://www.asterisksounds.org/pt-br/download/asterisk-sounds-core-pt-BR-sln16.zip',
  extract          => true,
  extract_path     => '/usr/share/asterisk/sounds/pt_BR',
  provider         => 'wget',
  download_options => '--continue ',
  require          => Package['asterisk'],
  cleanup          => true,
  creates          => '/usr/share/asterisk/sounds/pt_BR/agent-alreadyon.sln16',
}
-> archive { 'Add portuguese extra audio prompts':
  ensure           => present,
  path             => '/usr/src/asterisk-sounds-extra-pt-BR-1.11.10.zip',
  source           => 'https://www.asterisksounds.org/sites/asterisksounds.org/files/sounds/pt-BR/download/asterisk-sounds-extra-pt-BR-1.11.10.zip',
  extract          => true,
  extract_path     => '/usr/share/asterisk/sounds/pt_BR',
  provider         => 'wget',
  download_options => '--continue ',
  require          => Package['asterisk'],
  cleanup          => true,
  creates          => '/usr/share/asterisk/sounds/pt_BR/zombies.sln16',
}
freepbx::config::repo {['standard','extended','unsupported']:}
-> freepbx::config::module {[
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
  ]:
}
