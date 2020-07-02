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
  class { 'nodejs':
    repo_url_suffix => '8.x',
  }
  file { '/etc/yum.repos.d/webtatic.repo':
    ensure => file,
    mode   => '0644',
    source => 'puppet:///modules/freepbx/etc/yum.repos.d/webtatic.repo',
  }
  -> package { 'epel-release':
    ensure => installed,
  }
  ensure_packages($freepbx::freepbx_package_deps, {ensure=> 'present',require => Package['epel-release']})
  if $freepbx::asterisk_install {
    if $freepbx::asterisk_repo_install {
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
      creates          => "${freepbx::asterisk_sounds_folder}/pt_BR/agent-alreadyon.sln16",
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
