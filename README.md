## Table of Contents

1. [Overview](#overview)
1. [Module Description](#module-description)
1. [Setup](#setup)
1. [Usage](#usage)
   * [Example](#usage-example)
1. [Reference](#reference)
1. [Development](#development)
1. [License](#license)

## Overview

This module installs FreePBX open source IP PBX.

## Module Description

This module download, install and configure FreePBX with optional asterisk telephony framework and its dependencies installation.

This module is based on Sangoma ['Installing FreePBX 14 on CentOS 7'](https://wiki.freepbx.org/display/FOP/Installing+FreePBX+14+on+CentOS+7) document, but using asterisk packages from
[tucny repo](https://www.tucny.com/telephony/asterisk-rpms) instead of building it from source.

<!-- [puppet-staging](https://github.com/voxpupuli/puppet-staging): -->

* Implemented via resources, so beware of resource duplication

## Setup

This module requires the requirements:
* puppet-archive
* puppet-nodejs
* puppet-selinux
* puppet-yum
* puppetlabs-augeas_core
* puppetlabs-stdlib

## Usage

### Usage Example

Simple example that donwloads and installs FreePBX, asterisk and all dependencies

```puppet
include freepbx
```

More complex example :

This example will install asterisk 13, set verbose to 10, set SELinux mode and
reboot to apply SELinux changes
```puppet
class {'freepbx':
  asterisk_version     => 13,
  asterisk_verbose     => 10,
  selinux_mode         => 'permissive',
  reboot_after_install => true,
}
```

If you do not want to install asterisk using this module. Note that you must install
asterisk another way before including freepbx class
```puppet
class {'freepbx':
  asterisk_install => false
}
```

## Reference

* `asterisk_install`          = Enable or disable asterisk install. Default (boolean): true
* `asterisk_default_language` = Set asterisk default language in /etc/asterisk/asterisk.conf file. Default (string): 'en'
* `asterisk_verbose`          = Set asterisk verbose in /etc/asterisk/asterisk.conf file. Default (integer): 1
* `asterisk_repo_install`     = Enable or disable installation of asterisk related repos. Default (boolean): true
* `asterisk_version`          = Set asterisk version to be installed. Default (integer): 16
* `freepbx_version`           = Set FreePBX version to me installed. Only version 14 was tested. Default (integer): 14
* `reboot_after_install`      = Enable reboot after install. Default (boolean): false
* `selinux_mode`              = Set SELinux mode. Default (string): 'disabled'
* `selinux_type`              = Set SELinux type. Default (string): 'targeted'

## Limitations

This module was testes using CentOS 7, FreePBX 14 and asterisk 16.

## Development

Project URL: https://github.com/alisio/alisio-freepbx

Fell free to contribute to this module and submit your pull requests.

## License
Copyright 2019 Antonio Alisio de Meneses Cordeiro

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
