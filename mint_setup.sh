#!/bin/sh

############################################################################
# Welcome to the Linux Mint setup script!
#   1. Drop to a sudo shell (sudo -s)
#   2. Run setup script
#   3. Sit back and relax
############################################################################

apt-get install apt-transport-https -y
apt-get install libcurl3 -y

############################################################################
#### Desktop Environment
############################################################################

apt-get install i3 i3lock i3status suckless-tools -y
apt-get install feh alsa-base alsa-utils scrot -y

# copy configs
mkdir ~/.config/i3
wget https://raw.githubusercontent.com/mearlboro/settings/master/i3/config -P ~/.config/i3


############################################################################
#### Shell & terminal
############################################################################

apt-get install tmux -y

#< /etc/shells grep zsh
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

## Build essentials / Compilers
# https://help.ubuntu.com/community/InstallingCompilers
apt-get install build-essential libc++1 -y
# gcc -v
# make -v

## Haskell
apt-get install haskell-platform ghc haskell-stack cabal-install -y
cabal update

## Ruby
# Linux mint already ships with ruby, only install the dev packages
#gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E37D2BAF1CF37B13E2069D6956105BD0E739499BDB
#curl -sSL https://get.rvm.io | bash -s stable
#rvm install ruby
#rvm --default use ruby
#export PATH="$PATH:$HOME/.rvm/bin"
apt-get install ruby-dev -y
mkdir -p /home/share/gems
export GEM_HOME="/home/share/gems"
export PATH="/home/share/gems/bin:$PATH"

# Mint already ships with python and python3 so just install dev packages
#apt-get install python python3
apt-get install python3-pip python3-setuptools python3-pyqt5 python3-dev libssl-dev -y
ln -s /usr/bin/python3 /usr/local/bin/python
ln -s /usr/bin/easy_install3 /usr/local/bin/easy_install
pip3 install --upgrade pip
pip3 install virtualenv

## Perl
apt install perldoc cpan
cpan reload
cpan install Log::Log4perl
cpan install Regexp::Common

## PHP
apt-get install php -y

## Git
apt-get install git -y
apt-get install git-crypt -y

git config --global user.name "mearlboro"
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

# install vim, plugin manager, download my .vimrc, configure
apt-get install vim -y
gem install vim-update-bundles
wget https://raw.githubusercontent.com/mearlboro/settings/master/.vimrc -P ~/
vim-update-bundles

# install powerline fonts
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir /usr/share/fonts/opentype
mkdir /usr/share/fonts/opentype/powerline
mv PowerlineSymbols.otf /usr/share/fonts/opentype/powerline
fc-cache -vf /usr/share/fonts/opentype/powerline
mv 10-powerline-symbols.conf /etc/fonts/conf.d/

## Sublime
add-apt-repository ppa:webupd8team/sublime-text-2 -y
apt-get update
apt-get install sublime-text -y

## Latex
apt-get install texlive -y
apt-get install texlive-latex-base texlive-latex-extra texlive-bibtex-extra biber -y

############################################################################
#### Utilities & accessories
############################################################################

apt-get install redshift -y

# performance & monitoring
apt-get install tlp dstat htop nmon slurm ncdu -y

# file manager
apt-get install file nemo -y

# various linux utilities
apt-get install moreutils -y
apt-get install xclip -y
apt-get install pv -y

# archive
apt-get install unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller -y

# organize
apt-get install ccze tree colordiff exa -y


############################################################################
#### Email
############################################################################
apt-get install sendmail -y

add-apt-repository ppa:ubuntu-mozilla-security/ppa -y
apt-get update
apt-get install thunderbird -y

# protonmail
# https://protonmail.com/bridge/install
# https://protonmail.com/bridge/thunderbird
# needs files bridge_pubkey.gpg and bridge.pol
wget https://protonmail.com/download/protonmail-bridge_1.0.3-1_amd64.deb
apt-get install debsig-verify debian-keyring -y
mkdir -p /usr/share/debsig/keyrings/E2C75D68E6234B07
gpg --dearmor --output /usr/share/debsig/keyrings/E2C75D68E6234B07/debsig.gpg bridge_pubkey.gpg
rm bridge_pubkey.gpg
mkdir -p /etc/debsig/policies/E2C75D68E6234B07
mv bridge_16.04.pol /etc/debsig/policies/E2C75D68E6234B07
debsig-verify protonmail-bridge_1.0.3-1_amd64.deb
apt-get install ./protonmail-bridge_1.0.3-1_amd64.deb
rm protonmail-bridge_1.0.3-1_amd64.deb

# open MS office emails in linux
apt install libemail-outlook-message-perl libemail-sender-perl -y


################################################################################
#### Web
################################################################################

apt-get install whois dnsutils proxychain -y
apt-get install nmap -y

apt-get install filezilla -y
apt-get install thunderbird -y


## VPN
apt-get install openvpn dialog -y
apt-get install network-manager-openvpn -y
pip3 install protonvpn-cli

## Browsers
add-apt-repository ppa:ubuntu-mozilla-daily/ppa -y
apt-get install firefox -y

apt install tor -y
# sudo systemctl enable tor.service
add-apt-repository ppa:webupd8team/tor-browser -y
apt-get update -y
apt-get install tor-browser -y


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
cp yubioath-desktop-latest-linux.AppImage /home/share/yubico/yauth
apt install -y gnupg2 gnupg-agent dirmngr cryptsetup scdaemon pcscd secure-delete hopenpgp-tools
wget https://developers.yubico.com/yubikey-personalization-gui/Releases/yubikey-personalization-gui-3.1.25.tar.gz

## VPN
apt install network-manager openvpn network-manager-openvpn -y
apt install dialog -y
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
#### Media & social
############################################################################

# file systems
apt-get install exat-fuse exfat-utils -y

# video & graphics
apt-get install vlc -y
apt-get install inkscape -y
apt-get install gimp -y
apt-get install darktable -y
apt-get install fbreader -y

# social
add-apt-repository ppa:atareao/telegram -y
apt-get update -y
apt-get install telegram -y

wget -O slack.deb https://downloads.slack-edge.com/linux_releases/slack-desktop-3.0.2-amd64.deb
dpkg -i slack.deb
rm slack.deb

wget -O skype.deb http://go.skype.com/skypeforlinux-64.deb
dpkg -i skype.deb
apt-get -f install -y
rm skype.deb

curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
apt-get update -y
apt-get install signal-desktop -y

wget -qO - https://download.jitsi.org/jitsi-key.gpg.key | sudo apt-key add -
sh -c "echo 'deb https://download.jitsi.org stable/' > /etc/apt/sources.list.d/jitsi-stable.list"
apt-get update -y
apt-get install jitsi -y

wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
dpkg -i discord.deb
rm discord.deb

# Wire
wget -q https://wire-app.wire.com/linux/releases.key -O- | sudo apt-key add -
echo "deb [arch=amd64] https://wire-app.wire.com/linux/debian stable main" | sudo tee /etc/apt/sources.list.d/wire-desktop.list
apt-get update
apt-get install wire-desktop -y


############################################################################
#### Virtualisation
############################################################################

## install virtualbox
wget -O virtualbox.deb http://download.virtualbox.org/virtualbox/5.2.4/virtualbox-5.2_5.2.4-119785~Ubuntu~xenial_amd64.deb
dpkg -i virtualbox.deb
rm virtualbox.deb

## Extension pack - will open virtualbox - TODO: silent install
wget https://download.virtualbox.org/virtualbox/5.2.4/Oracle_VM_VirtualBox_Extension_Pack-5.2.4-119785.vbox-extpack
virtualbox Oracle_VM_VirtualBox_Extension_Pack-5.2.4-119785.vbox-extpack


###
sudo reboot

