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
class {'freepbx': reboot_after_install => false }
