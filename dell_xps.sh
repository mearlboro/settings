#!/bin/sh

# this wonderful script can kickstart linux mint on a dell xps 2017 with a
# nvidia graphics card
# update kernel and drop to an elevated command prompt before running

apt-get update && apt-get upgrade

############################################################################
cp /etc/default/grub /etc/default/grub.backup

# make sure ACPI is set to oldboot in grub; otherwise it hangs at boot, or
# boots with no touchpad or power management
#sed -i -e 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi=oldboot"/g' /etc/default/grub

# if the above option doesn't work try
sed -i -e 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi_rev_override=5"/g' /etc/default/grub

update-grub

############################################################################
#### Drivers- Nvidia
apt-get purge nvidia-*
apt install nvidia-384      # serious bugs with newer version as of Jan 2018
apt install nvidia-prime    # to switch between graphics cards
apt install nvidia-settings # Nvidia X Settings panel
#prime-select nvidia        # select nvidia as main GPU


############################################################################
# Enable suspend on lid close
sed -i -e 's/HandleLidSwitch=ignore/HandleLidSwitch=hibernate/g' /etc/systemd/logind.conf


###########################################################################
# optimisation and power management with TLP
# http://linrunner.de/en/tlp/tlp.html
add-apt-repository ppa:linrunner/tlp
apt-get update
apt install tlp tlp-rdw -y
tlp start

