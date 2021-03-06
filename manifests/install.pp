# @summary Installs freepbx repos and packages
#
# A description of what this class does
#
# @example
#   include freepbx::install
class freepbx::install inherits freepbx {
  yum::group { $freepbx::freepbx_groups_deps :
    ensure => 'present';
  }
  archive { '/usr/src/node-v8.9.4-linux-x64.tar.gz' :
    ensure           => present,
    source           => 'https://nodejs.org/dist/v8.9.4/node-v8.9.4-linux-x64.tar.gz',
    extract          => true,
    extract_path     => '/usr/local',
    provider         => 'wget',
    extract_flags    => '--strip-components 1 -xzvf',
    download_options => '--continue --no-check-certificate',
    creates          => '/usr/local/bin/node',
    cleanup          => true,
  }
  if $freepbx::package_repo_install {
    file { '/etc/yum.repos.d/webtatic.repo':
      ensure => file,
      mode   => '0644',
      source => 'puppet:///modules/freepbx/etc/yum.repos.d/webtatic.repo',
    }
    -> package { 'epel-release':
      ensure => installed,
    }
    ensure_packages($freepbx::freepbx_package_deps, {ensure=> 'present',require => Package['epel-release']})
  } else {
    ensure_packages($freepbx::freepbx_package_deps, {ensure=> 'present'})
  }
  if $freepbx::asterisk_install {
    if $freepbx::package_repo_install {
      file { '/etc/yum.repos.d/asterisk.repo':
        ensure  => file,
        content => template('freepbx/etc/yum.repos.d/asterisk.repo.erb'),
        mode    => '0644',
      }
      ensure_packages(
        $freepbx::asterisk_packages, {
          ensure => 'present', require => File['/etc/yum.repos.d/asterisk.repo']
        }
      )
    } else {
      ensure_packages(
        $freepbx::asterisk_packages, {
          ensure => 'present'
        }
      )
    }
    file { [$freepbx::asterisk_sounds_folder,"${freepbx::asterisk_sounds_folder}/pt_BR"]:
      ensure  => directory,
      mode    => '0644',
      owner   => 'asterisk',
      group   => 'asterisk',
      require => Package['asterisk'],
    }
  }
  archive { "/usr/src/${freepbx::freepbx_version}-latest.tgz" :
    ensure           => present,
    source           => "http://mirror.freepbx.org/modules/packages/freepbx/freepbx-${freepbx::freepbx_version}-latest.tgz",
    extract          => true,
    extract_path     => '/usr/src',
    provider         => 'wget',
    download_options => '--continue --no-check-certificate',
    require          => Package['httpd'],
    cleanup          => true,
  }
}
