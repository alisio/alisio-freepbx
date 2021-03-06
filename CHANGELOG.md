# Changelog

## Release 0.1.6

**Features**

**Bugfixes**
- Set php_set_memory_limit to 256M
- freepbx::config::repo doesn't check if repos are enabled and runs everytime

**Known Issues**
- FreePBX module installation check takes too long when several modules are managed through puppet

## Release 0.1.5

**Features**
- Add pt_BR extra audio install to test manifest
- Add wav music on hold package

**Bugfixes**
- Fix asterisk sounds folder

**Known Issues**
- freepbx::config::repo doesn't check if repos are enabled and runs everytime

## Release 0.1.4

**Bugfixes**

- Remove unused variable

**Known Issues**
- freepbx::config::repo doesn't check if repos are enabled and runs everytime

## Release 0.1.3

**Features**

- Remove puppet-nodejs module depedency
- Add package_repo_install for control installation of related repositories

**Bugfixes**

- Remove garbage characters from README

**Known Issues**
- freepbx::config::repo doesn't check if repos are enabled and runs everytime

## Release 0.1.2

**Features**

- Add testing instructions to the README file

**Bugfixes**

- Fix freepbx::module defined type
- Apply button throws an error

**Known Issues**
- Error when applying changes. Fixed running /var/lib/asterisk/bin/retrieve_conf

## Release 0.1.1

**Features**

- Set FreePBX file ownership during install
- Update README

**Bugfixes**

- Fix freepbx::module defined type

**Known Issues**
- Error when applying changes. Fixed running /var/lib/asterisk/bin/retrieve_conf

## Release 0.1.0

- First Release
