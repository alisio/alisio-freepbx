## Table of Contents

1. [Overview](#overview)
1. [Module Description](#module-description)
1. [Setup](#setup)
1. [Usage](#usage)
   * [Example](#usage-example)
   * [Testing](#testing)
1. [Reference](#reference)
   * [Classes](#classes)
   * [Defined Types](#defined-types)
   * [Resources](#resources)
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

Simple example that downloads and installs FreePBX, asterisk and all dependencies

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

### Testing

#### In a virtualbox machine using Vagrant
It is possible to use vagrant to provision a VM for testing purposes. All you
have to do is type:

```sh
# Start the VM
vagrant up
# Access VM terminal
vagrant ssh
```
Once the provisioning ends you can type the VM's IP address to access the FreePBX Web UI.

#### In a remote server using bolt

Installing a test FreePBX on a remote server using bolt (mind you that a passwordless ssh key access must be configured first):

```sh
bolt task run puppet_agent::install --targets SERVER_IP_ADDRESS -u root
bolt file upload tests/freepbx.pp /tmp/freepbx.pp --targets SERVER_IP_ADDRESS -u root
bolt command run '/opt/puppetlabs/bin/puppet module install alisio-freepbx' --targets SERVER_IP_ADDRESS -u root
bolt command run '/opt/puppetlabs/bin/puppet apply /tmp/freepbx.pp' --targets SERVER_IP_ADDRESS -u root

```
Once the provisioning ends you can type IP address of the server on your browser to access the FreePBX Web UI.

#### In a local server

Installing locally on a server:

```bash
rpm -Uvh https://yum.puppet.com/puppet5-release-el-7.noarch.rpm
yum -y --nogpgcheck install puppet-agent git
/opt/puppetlabs/bin/puppet module install alisio-freepbx
git clone https://github.com/alisio/alisio-freepbx.git
/opt/puppetlabs/bin/puppet apply alisio-freepbx/tests/freepbx.pp
```
Once the provisioning ends you can type IP address of the server on your browser to access the FreePBX Web UI.

## Reference

### Classes

* `freepbx`: Install FreePBX and its dependencies

### Defined Types

* `freepbx::config::repo` : Enable or disable FreePBX repositories
* `freepbx::config::module`: Install or remove FreePBX modules


### Resources

#### Freepbx

* `asterisk_install`          = Enable or disable asterisk install. Default (boolean): true
* `asterisk_default_language` = Set asterisk default language in /etc/asterisk/asterisk.conf file. Default (string): 'en'
* `asterisk_verbose`          = Set asterisk verbose in /etc/asterisk/asterisk.conf file. Default (integer): 1
* `asterisk_repo_install`     = Enable or disable installation of asterisk related repos. Default (boolean): true
* `asterisk_version`          = Set asterisk version to be installed. Default (integer): 16
* `freepbx_version`           = Set FreePBX version to me installed. Only version 14 was tested. Default (integer): 14
* `reboot_after_install`      = Enable reboot after install. Default (boolean): false
* `selinux_mode`              = Set SELinux mode. Default (string): 'disabled'
* `selinux_type`              = Set SELinux type. Default (string): 'targeted'

#### Freepbx::config::repo

* `repo`: The name of the repository.
* `enable`: Enable or disable repository. Default (boolean): true
* `timeout`: Timeout for the operation in seconds. Default (integer): 120,

#### Freepbx::config::module

* `module`: Name of the module
* `ensure`: Ensure that the module is present or absent. Default (string): present
* `timeout`: Timeout for the operation in seconds. Default (integer): 120

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
