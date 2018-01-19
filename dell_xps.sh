#!/bin/sh

# this wonderful script can kickstart linux mint on a dell xps 2017 with a
# nvidia graphics card
# update kernel and drop to an elevated command prompt before running

apt-get update && apt-get upgrade

############################################################################
# make sure ACPI is set to oldboot in grub; otherwise it hangs at boot, or 
# boots with no touchpad or power management
cp /etc/default/grub /etc/default/grub.backup
sed -i -e 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi=oldboot"/g' /etc/default/grub
update-grub


############################################################################
#### Drivers- Nvidia
apt-get purge nvidia-*
apt install nvidia-384      # serious bugs with newer version as of Jan 2018
apt install nvidia-prime    # to switch between graphics cards
apt install nvidia-settings # Nvidia X Settings panel
prime-select nvidia         # select nvidia as main GPU


############################################################################
# Enable suspend on lid close
sed -i -e 's/HandleLidSwitch=ignore/HandleLidSwitch=suspend/g' /etc/systemd/logind.conf

