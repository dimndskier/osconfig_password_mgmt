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
class osconfig_password_mgmt {
        include implement
        include backout
}



