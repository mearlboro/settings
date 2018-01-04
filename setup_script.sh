#!/bin/sh

apt-get update && apt-get upgrade


############################################################################
#### Dev
############################################################################

## Compilers 
# https://help.ubuntu.com/community/InstallingCompilers
apt-get install build-essential -y
# gcc -v
# make -v
apt-get install ghc -y
apt-get install php -y

# python stuff
apt-get install python3 python3-pip python3-setuptools python3-pyqt5 -y
pip3 install --upgrade pip -y

# perl stuff
cpan install CPAN
cpan reload


## Editors
apt-get install vim -y

add-apt-repository ppa:webupd8team/sublime-text-2 -y
apt-get update
apt-get install sublime-text -y

apt-get install texlive -y

apt-get install tmux -y


## Git
apt-get install git -y
apt-get install git-crypt -y

git config --global user.name "mearlboro"
git config --global user.email "mearlboro@protonmail.com"
git config --global branch.autosetuprebase always
git config --global color.ui true

# leave Windows line endings alone
git config --global core.autocrlf input


############################################################################
#### Accessories
############################################################################

apt-get install nautilus -y

# archive
apt-get install unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller -y

# email
apt-get install sendmail -y

add-apt-repository ppa:ubuntu-mozilla-security/ppa -y
apt-get update
apt-get install thunderbird -y


################################################################################
#### Web
################################################################################

apt-get install whois -y

add-apt-repository ppa:ubuntu-mozilla-daily/ppa
apt-get install firefox -y


apt-get install filezilla -y

## networking
apt-get install openssh-server -y

## VPN
apt-get install openvpn -y
apt-get install openvpn bridge-utils -y
apt-get install network-manager-openvpn network-manager-openvpn-gnome -y


## Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - 
sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
apt-get update 
apt-get install google-chrome-stable


############################################################################
#### Media and social
############################################################################
apt-get install vlc -y
# apt-get install deluge y # torrents

# Telegram
add-apt-repository ppa:atareao/telegram -y
apt-get update
apt-get install telegram -y

apt-get install slack -y

# Skype
wget -O skype.deb http://go.skype.com/skypeforlinux-64.deb
dpkg -i skype.deb
apt-get -f install -y
rm skype.deb

# Signal
curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list

apt-get update
apt-get install signal-desktop


############################################################################
#### Virtualisation
############################################################################

wget -O libvpx.deb http://ftp.us.debian.org/debian/pool/main/libv/libvpx/libvpx1_1.1.0-1_amd64.deb
sudo dpkg -i libvpx.deb
wget -O libpng.deb http://ftp.cn.debian.org/debian/pool/main/libp/libpng/libpng12-0_1.2.49-1+deb7u2_amd64.deb
sudo dpkg -i libpng.deb
rm -f libvpx.deb
rm -f libpng.deb

apt-get install virtualbox -y
apt-get install virtualbox-dkms -y
apt-get install virtualbox-qt -y
apt-get install virtualbox-guest-utils -y

usermod -a -G vboxusers `whoami`
sudo sh -c "echo 'deb http://download.virtualbox.org/virtualbox/debian '$(lsb_release -cs)' contrib non-free' > /etc/apt/sources.list.d/virtualbox.list"
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -   # for linux mint 18

###
sudo reboot
