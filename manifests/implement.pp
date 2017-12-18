#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2017 Your name here, unless otherwise noted.
#
#  Explanation of Paramaters: roothash, sysadmhash and grubhash
#       ---Use the script 'generate-hash.sh' found on The Red Hat Satellite under Root's (/root) Home Directory to generate the hash appropriate.
#       roothash        : Just provide the SHA-512 hash to this field, to alter the /etc/shadow copy of the hash for 'root'.  
#       sysadmhash      : Just provide the SHA-512 hash to this field, to alter the /etc/shadow copy of the hash for 'sysadm'.
#       grubhash        : For the OS=
#               'redhat-6' - Just provide the SHA-512 hash to this field, to alter the value to the appropriate (password --encrypted ....) line in the /boot/grub/grub.conf.
#
#               'redhat-7' - Just provide the PBKDF2 hash to this field, to alter the GRUB2_PASSWORD value found in /boot/grub2/user.cfg.
#
#  PARAMETERS=====
#       roothash        : The SHA512 password hash for the local account - root.
#       sysadmhash      : The SHA512 password hash for the local account - sysadm.
#       grubhash        : The SHA512/PBKDF2 password hash for the GRUB2 account - root.
#       grubchanged     : A date-string <in DDMMMYY form> for a relative date when the passwords were ALL changed.
#
class osconfig_password_mgmt::implement (
  $roothash    = 'Place_sha512_Root_hash_here',
  $sysadmhash  = 'Place_sha512_Sysadm_hash_here',
  $grubhash    = 'Place_GRUB(1or2)_hash_here',
  $grubchanged = '15JAN18'
) {
# Case statement evaluates ONLYIF a machine is 'redhat-6' or 'redhat-7'.
  case "${os_brand}-${os_revision}" {  # Start CASE 1
    'redhat-6': {
      exec {'alter_grub1_password':
        command => template('osconfig_password_mgmt/GRUB1_change.sh.erb'),
        path    => "/usr/bin:/bin:/usr/sbin:/sbin",
        unless  => "test -f /boot/grub/grub.conf.backup-$grubchanged",
        creates => "/boot/grub/grub.conf.backup-$grubchanged"
      } ->

      file { '/boot/grub/grub.conf':
        ensure   => 'file',
        owner    => '0',
        group    => '0',
        mode     => '0600',
        selrange => 's0',
        selrole  => 'object_r',
        seltype  => 'boot_t',
        seluser  => 'unconfined_u',
      }

      user { 'root':
        ensure           => 'present',
        forcelocal       => 'true',
        comment          => 'root',
        uid              => '0',
        gid              => '0',
        home             => '/root',
        password         => "$roothash",
        password_max_age => '99999',
        password_min_age => '0',
        shell            => '/bin/bash',
      }

      user { 'sysadm':
        ensure           => 'present',
        forcelocal       => 'true',
        comment          => 'Sysadm Acct',
        uid              => '1000',
        gid              => '1000',
        groups           => ['adm', 'wheel', 'sysadm'],
        home             => '/home/sysadm',
        password         => "$sysadmhash",
        password_max_age => '99999',
        password_min_age => '0',
        shell            => '/bin/bash',
      }


    } # End CAVEAT redhat-6
#
#
#
    'redhat-7': {
      exec {'remove_united_grub2_config':
        command => template('osconfig_password_mgmt/GRUB2_remove_united.sh.erb'),
        path    => "/usr/bin:/bin:/usr/sbin:/sbin",
        unless  => "test -f /boot/grub2/grub.cfg.backup-$grubchanged",
        creates => "/boot/grub2/grub.cfg.backup-$grubchanged"
      } ->

      file { '/boot/grub2/user.cfg':
        ensure   => 'file',
        owner    => '0',
        group    => '0',
        mode     => '0600',
        selrange => 's0',
        selrole  => 'object_r',
        seltype  => 'boot_t',
        seluser  => 'system_u',
        content  => template('osconfig_password_mgmt/GRUB2_user.cfg.erb')
      }

      user { 'root':
        ensure           => 'present',
        forcelocal       => 'true',
        comment          => 'root',
        uid              => '0',
        gid              => '0',
        home             => '/root',
        password         => "$roothash",
        password_max_age => '99999',
        password_min_age => '0',
        shell            => '/bin/bash',
      }

      user { 'sysadm':
        ensure           => 'present',
        forcelocal       => 'true',
        comment          => 'Sysadm Acct',
        uid              => '1000',
        gid              => '1000',
        groups           => ['adm', 'wheel', 'sysadm'],
        home             => '/home/sysadm',
        password         => "$sysadmhash",
        password_max_age => '99999',
        password_min_age => '0',
        shell            => '/bin/bash',
      }

    } # End CAVEAT redhat-7
  } # End CASE 1
} # End CLASS



