#!/bin/sh

############################################################################
# Welcome to the PureOS setup script!
#   1. Drop to a sudo shell (sudo -s)
#   2. Run setup script
#   3. Sit back and relax
############################################################################

apt-get install apt-transport-https -y
apt-get install libcurl3 -y

# Fix keyboard bug
setxkbmap -layout gb
echo "# Purism Librem 13 V2/V3/V4
evdev:atkbd:dmi:bvn*:bvr*:bd*:svnPurism*:pn*Librem13v[2-4]*:pvr*
 KEYBOARD_KEY_56=102nd" > /etc/udev/hwdb.d/70-keyboard.hwdb
systemd-hwdb update
udevadm trigger

############################################################################
#### Desktop Environment
############################################################################

apt-get install i3 i3lock i3status suckless-tools -y
apt-get install feh alsa-base alsa-utils scrot -y

# copy configs
mkdir ~/.config/i3
wget https://raw.githubusercontent.com/mearlboro/settings/master/i3/config -P ~/.config/i3
wget https://raw.githubusercontent.com/mearlboro/settings/master/i3/brightness.sh -P ~/.config/i3
wget https://raw.githubusercontent.com/mearlboro/settings/master/i3/screenshot.sh -P ~/.config/i3
chmod +x brightness.sh
chmod +x screenshot.sh
echo "\n$SUDO_USER ALL=(root) NOPASSWD: /home/m/.config/i3/brightness.sh" >> /etc/sudoers


############################################################################
#### Shell & terminal
############################################################################

apt-get install tmux -y

# install shell, make default, load
apt install zsh -y
chsh -s /bin/zsh $SUDO_USER

# download configs
wget https://raw.githubusercontent.com/mearlboro/settings/master/.zshrc -P ~/
mkdir ~/.zsh/themes/
git clone https://github.com/bhilburn/powerlevel9k.git ~/.zsh/themes/powerlevel9k
source ~/.zshrc



############################################################################
#### Dev
############################################################################

apt-get install build-essential libc++1 -y

apt-get install haskell-platform ghc haskell-stack cabal-install -y
cabal update

apt-get install ruby-dev -y
mkdir -p /home/share/gems
export GEM_HOME="/home/share/gems"
export PATH="/home/share/gems/bin:$PATH"

apt-get install python3-pip python3-setuptools python3-pyqt5 python3-dev libssl-dev -y
ln -s /usr/bin/python3 /usr/local/bin/python
ln -s /usr/bin/easy_install3 /usr/local/bin/easy_install
pip3 install --upgrade pip
pip3 install virtualenv

## Git
apt-get install git -y
apt-get install git-crypt -y

git config --global user.name "M"
git config --global user.email "mearlboro@protonmail.com"
git config --global color.ui true
# don't show changes of permissions in diff
git config --global core.filemode false
# leave Windows line endings alone
git config --global core.autocrlf input
# always add your changes on top when pulling
git config --global branch.autosetuprebase always


#############################################################################
#### Editors
############################################################################

## install vim, plugin manager, download my .vimrc, configure
apt-get install vim -y
gem install vim-update-bundles
wget https://raw.githubusercontent.com/mearlboro/settings/master/.vimrc -P ~/
vim-update-bundles

## install powerline fonts
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir /usr/share/fonts/opentype
mkdir /usr/share/fonts/opentype/powerline
mv PowerlineSymbols.otf /usr/share/fonts/opentype/powerline
fc-cache -vf /usr/share/fonts/opentype/powerline
mv 10-powerline-symbols.conf /etc/fonts/conf.d/

## Latex
apt-get install texlive -y
apt-get install texlive-latex-base texlive-latex-extra texlive-bibtex-extra biber -y


############################################################################
#### Utilities & Accessories
############################################################################

apt-get install redshift -y

# performance & monitoring
apt-get install tlp dstat htop nmon slurm ncdu -y

# file manager
apt-get install file -y

# various linux utilities
apt-get install moreutils -y
apt-get insrall xclip -y
apt-get install pv -y

# archive
apt-get install unace zip unzip p7zip-full sharutils uudeview mpack arj cabextract file-roller -y

# organize & colour
apt-get install ccze tree colordiff exa -y


################################################################################
#### Web
################################################################################

apt-get install whois dnsutils proxychain -y
apt-get install nmap -y

apt-get install filezilla -y

apt-get install thunderbird -y

# Browsers
apt install tor -y


################################################################################
#### Security
################################################################################

apt-get install openssh-server -y

## Yubikey
wget https://developers.yubico.com/yubikey-manager-qt/Releases/yubikey-manager-qt-latest-linux.AppImage
wget https://developers.yubico.com/yubioath-desktop/Releases/yubioath-desktop-latest-linux.AppImage
mkdir -p /home/share/yubico
export PATH="/home/share/yubico:$PATH"
cp yubikey-manager-qt-latest-linux.AppImage /home/share/yubico/yubimgr
cp yubioath-desktop-latest-linux.AppImage   /home/share/yubico/yauth
apt install -y gnupg2 gnupg-agent dirmngr cryptsetup scdaemon pcscd secure-delete hopenpgp-tools
wget https://developers.yubico.com/yubikey-personalization-gui/Releases/yubikey-personalization-gui-3.1.25.tar.gz

## VPN
apt install network-manager openvpn network-manager-openvpn -y
apt install dialog python3-pip python3-setuptools -y
pip3 install protonvpn-cli

add-apt-repository ppa:wireguard/wireguard -y
apt-get update -y
sudo apt-get install openresolv curl linux-headers-$(uname -r) wireguard-dkms wireguard-tools

# protonmail bridge
# https://protonmail.com/bridge/install
# https://protonmail.com/bridge/thunderbird
# needs files bridge_pubkey.gpg and bridge.pol
wget https://protonmail.com/download/protonmail-bridge_1.2.3-1_amd64.deb
apt-get install debsig-verify debian-keyring -y
mkdir -p /usr/share/debsig/keyrings/E2C75D68E6234B07
gpg --dearmor --output /usr/share/debsig/keyrings/E2C75D68E6234B07/debsig.gpg bridge_pubkey.gpg
rm bridge_pubkey.gpg
mkdir -p /etc/debsig/policies/E2C75D68E6234B07
mv bridge_16.04.pol /etc/debsig/policies/E2C75D68E6234B07
debsig-verify protonmail-bridge_1.2.3-1_amd64.deb
apt-get install ./protonmail-bridge_1.2.3-1_amd64.deb


############################################################################
#### Media
############################################################################

# file systems
apt-get install exfat-fuse exfat-utils -y

# graphics
apt-get install vlc -y
apt-get install inkscape -y
apt-get install gimp -y
apt-get install darktable -y
apt-get install fbreader -y
