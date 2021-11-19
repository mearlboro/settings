#!/bin/sh

############################################################################
# Welcome to the PureOS install script!
#   1. Drop to a sudo shell (sudo -s)
#   2. Run setup script
#   3. Sit back and relax
############################################################################

# Generic Utilities
apt-get install apt-transport-https -y
apt-get install openresolv curl -y
apt-get install ca-certificates software-properties-common libssl-dev -y

# Fix keyboard bug
echo "# Purism Librem 13 V2/V3/V4
evdev:atkbd:dmi:bvn*:bvr*:bd*:svnPurism*:pn*Librem13v[2-4]*:pvr*
 KEYBOARD_KEY_56=102nd" > /etc/udev/hwdb.d/70-keyboard.hwdb
systemd-hwdb update
udevadm trigger

############################################################################
#### Desktop Environment
############################################################################

apt-get install i3 i3lock i3status dunst suckless-tools -y


############################################################################
#### Shell & terminal
############################################################################

apt-get install tmux -y

# install shell, make default, load
apt-get install zsh -y
chsh -s /bin/zsh $SUDO_USER


############################################################################
#### Dev
############################################################################

# Languages
apt-get install build-essential libc++1 -y

apt-get install python3-pip python3-setuptools python3-distutils python3-apt -y
pip3 install python3-dev pipenv bpython typing mypy importlib

apt-get install haskell-platform ghc haskell-stack nix cabal-install -y
cabal update

apt-get install ruby ruby-dev -y
mkdir -p /home/share/gems
export GEM_HOME="/home/share/gems"
export PATH="/home/share/gems/bin:$PATH"
gem install bundler


## Git
apt-get install git -y
apt-get install git-crypt -y
apt-get install meld -y


#############################################################################
#### Editors
############################################################################

apt-get install vim -y

apt-get install texlive texlive-xetex texlive-latex-base texlive-latex-extra texlive-bibtex-extra biber -y


############################################################################
#### System Utilities & Accessories
############################################################################

# terminal UI tools and goodies
apt-get install scrot -y
apt-get install nmtui-connect -y
apt-get install ccze tree colordiff rdfind -y

# Rust replacements for GNU tools
apt-get install exa ripgrep fd-find bat -y

# performance & monitoring
apt-get install tlp dstat htop nmon slurm ncdu neofetch -y

# file manager
apt-get install file nemo -y

# various linux utilities
apt-get install moreutils xclip pv -y

# archive
apt-get install tar zip unzip p7zip-full -y


################################################################################
#### Web
################################################################################

apt-get install whois dnsutils proxychain -y
apt-get install nmap netcat -y

apt-get install mutt thunderbird sendmail enigmail -y

# open MS office emails in linux
#apt-get install libemail-outlook-message-perl libemail-sender-perl -y


################################################################################
#### Security
################################################################################

apt-get install debsig-verify debian-keyring -y
apt-get install gnupg2 gnupg-agent dirmngr cryptsetup scdaemon pcscd secure-delete hopenpgp-tools -y
apt-get install openssh-server -y

## Tor
wget -qO- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --import
gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -
echo "deb [arch=amd64] https://deb.torproject.org/torproject.org focal main" | tee /etc/apt/sources.list.d/tor.list

apt-get update
apt-get install tor deb.torproject.org-keyring

## Yubikey
wget https://developers.yubico.com/yubikey-manager-qt/Releases/yubikey-manager-qt-latest-linux.AppImage
wget https://developers.yubico.com/yubioath-desktop/Releases/yubioath-desktop-latest-linux.AppImage
mkdir -p /home/share/yubico
export PATH="/home/share/yubico:$PATH"
mv yubikey-manager-qt-latest-linux.AppImage /home/share/yubico/yubimgr
mv yubioath-desktop-latest-linux.AppImage   /home/share/yubico/yauth
wget https://developers.yubico.com/yubikey-personalization-gui/Releases/yubikey-personalization-gui-3.1.25.tar.gz -P ~/Downloads
apt-get install yubico-piv-tool ykcs -y

## VPN
apt-get install network-manager openvpn network-manager-openvpn -y
apt-get install dialog -y
pip3 install protonvpn-cli

add-apt-repository ppa:wireguard/wireguard -y
apt-get update -y
apt-get install linux-headers-$(uname -r) wireguard-dkms wireguard-tools -y

# protonmail bridge
# https://protonmail.com/bridge/install
# https://protonmail.com/bridge/thunderbird
wget https://protonmail.com/download/protonmail-bridge_1.5.7-1_amd64.deb -P ~/Downloads
wget https://protonmail.com/download/bridge_pubkey.gpg
wget https://protonmail.com/download/bridge.pol
mkdir -p /usr/share/debsig/keyrings/E2C75D68E6234B07
gpg --dearmor --output /usr/share/debsig/keyrings/E2C75D68E6234B07/debsig.gpg bridge_pubkey.gpg
rm bridge_pubkey.gpg
mkdir -p /etc/debsig/policies/E2C75D68E6234B07
mv bridge.pol /etc/debsig/policies/E2C75D68E6234B07
debsig-verify ~/Downloads/protonmail-bridge_1.5.7-1_amd64.deb
apt-get install ~/Downloads/protonmail-bridge_1.5.7-1_amd64.deb


############################################################################
#### Media
############################################################################

# file systems
apt-get install exfat-fuse exfat-utils -y

# video & graphics
apt-get install arandr -y
apt-get install mpv vlc ffmpeg -y
apt-get install feh inkscape gimp darktable -y
apt-get install font-viewer -y

# sound
apt-get install cmus -y
apt-get install alsa-base alsa-utils pavucontrol amixer -y
apt-get install audacity -y

# text & books
apt-get install abiword -y
apt-get install calibre pandoc zathura -y

# messengers
wget -O- https://updates.signal.org/desktop/apt/keys.asc | apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | tee /etc/apt/sources.list.d/signal-desktop.list

apt-key adv --fetch-keys http://wire-app.wire.com/linux/releases.key
echo "deb https://wire-app.wire.com/linux/debian stable main" | tee /etc/apt/sources.list.d/wire-desktop.list

apt-get update
apt-get install signal-desktop wire-desktop
