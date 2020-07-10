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
package { [
    'augeas',
    'mlocate',
    # 'sngrep',
    'vim',
  ]:
  ensure => installed,
}
class {'freepbx':
  reboot_after_install => false,
  package_repo_install => false,
}
-> archive { 'Add portuguese audio prompts':
  ensure           => present,
  path             => '/usr/src/asterisk-sounds-core-pt-BR-sln16.zip',
  source           => 'https://www.asterisksounds.org/pt-br/download/asterisk-sounds-core-pt-BR-sln16.zip',
  extract          => true,
  extract_path     => '/var/lib/asterisk/sounds/pt_BR',
  provider         => 'wget',
  download_options => '--continue ',
  require          => Package['asterisk'],
  cleanup          => true,
  creates          => '/var/lib/asterisk/sounds/pt_BR/agent-alreadyon.sln16',
}
freepbx::config::repo {['standard','extended','unsupported']:}
-> freepbx::config::module {[
    'announcement',
    'backup',
    'blacklist',
    'certman',
    'customcontexts',
    'callforward',
    'callwaiting',
    'callback',
    # 'campon',
    'donotdisturb',
    'dundicheck',
    'endpointman',
    'fax',
    'findmefollow',
    'hotelwakeup',
    'iaxsettings',
    'ivr',
    'manager',
    'miscapps',
    'miscdests',
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
