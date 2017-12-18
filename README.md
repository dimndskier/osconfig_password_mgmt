# osconfig_password_mgmt

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [MAS Machine Types Applicable](#mas-machine-types-applicable)
4. [Setup - The basics of getting started with osconfig_password_mgmt](#setup)
    * [What osconfig_password_mgmt affects](#what-osconfig_password_mgmt-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with osconfig_password_mgmt](#beginning-with-osconfig_password_mgmt)
5. [Usage - Configuration options and additional functionality](#usage)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Development - Guide for contributing to the module](#development)
8. [ChangeLog - documented from newest on top, down to oldest](#changelog)

## Overview

One module to control:
* The __GRUB1__ password for redhat-6 machines,
* The __GRUB2__ password for redhat-7 machines,
* The Local (/etc/shadow) Password for __root__ on all machines,
* The Local (/etc/shadow) Password for __sysadm__ on all machines,
on a per-HostGroup basis; by updating the password-hashes appropriately.

## Module Description

This module will assess whether the machine is a 'redhat-6' or 'redhat-7' machine
 and then alter the GRUB (or GRUB2) password, the root account and sysadm account 
 password hash.

## MAS Machine Types Applicable
* `redhat-6-client`, `redhat-6-workstation`
* `redhat-7-client`, `redhat-7-workstation`
* `redhat-7-VDA-server`, `redhat-7-CAP-server`
* `redhat-7-LFS-server`, `redhat-7-IPA-server`

## Setup

### What osconfig_password_mgmt affects

This module effectively automates the consistent replacement of the password hashes
 for: GRUB1 (on redhat-6), GRUB2 (on redhat-7), root (on all redhat machines) and
 sysadm (on all redhat machines).

### Setup Requirements 

This module requires the use of the `generate-hash.sh` shell script as written on
 Satellite server under Root's home directory.

### Beginning with osconfig_password_mgmt

The steps are very basic:
1. Determine the value of your password for humans to know,
2. Use the `generate-hash.sh` script to generate the appropriate hash,
3. Copy/paste new hash into Parameter-field for the appropriate parameter 
  for the correct HostGroup to receive the associated hash-password-value.

## Usage

* Classes: osconfig_password_mgmt (That is it!)
* Types: user, exec
* Resources: GRUB1_change.sh.erb, GRUB2_user.cfg.erb and GRUB2_remove_united.sh.erb
* Parameters: __grubhash, sysadmhash, roothash__ and __grubchanged__

## Limitations

This module is compatible only with Red Hat (6 & 7) variants.  Testing is __MANDATORY__ though
 for all OSes before releasing to Production.

## Development

Use at your own risk.


## ChangeLog 
####### documented from newest on top, down to oldest.

mm/dd/yyyy(newest on top)       -ModuleName_Rev-Maj.Min        `-Addresses={DR#....,DR#....}`   -BITS=number    -Author;

12/13/2017      -__osconfig_password_mgmt-0.0.5__     `-Addresses={RMIS_buildout}`       -BITS=2909.57113_OSCONFIG_PASSWORD_MGMT.0000.1          -WFrench;
        Corrected backout.pp, because it was not properly "recovering" to the prior copy of grub.conf; now it does.

12/13/2017      -__osconfig_password_mgmt-0.0.4__     `-Addresses={RMIS_buildout}`       -BITS=2909.57113_OSCONFIG_PASSWORD_MGMT.0000.1          -WFrench;
        Corrected the Backout manifest, because it was not properly "recovering" to the prior copy of grub.cfg; now it does.

12/12/2017      -__osconfig_password_mgmt-0.0.3__     `-Addresses={RMIS_buildout}`       -BITS=2909.57113_OSCONFIG_PASSWORD_MGMT.0000.1          -WFrench;
        Updated both the Implement and Backout manifest to reference the GRUB2 cfg-file because it was referenced as a conf-file.  Also corrected the ERB-templates
         associated with GRUB2 on redhat-7 machines for the same reason (.cfg versus .conf).

12/07/2017      -__osconfig_password_mgmt-0.0.2__     `-Addresses={RMIS_buildout}`       -BITS=2909.57113_OSCONFIG_PASSWORD_MGMT.0000.1          -WFrench;
        Updated a little more, still not tested at all.

12/05/2017      -__osconfig_password_mgmt-0.0.1__     `-Addresses={RMIS_buildout}`       -BITS=2909.57113_OSCONFIG_PASSWORD_MGMT.0000.1          -WFrench;
        Initial development of the module.




