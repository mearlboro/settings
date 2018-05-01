#!/bin/sh


############################################################################
# add basic repos to sources.list and update
echo "deb http://ftp.debian.org/debian sylvia main contrib non-free" | sudo tee -a /etc/apt/sources.list
apt-get update && apt-get upgrade

# kernel update utility
apt install ukuu -y


############################################################################
#### Dev
############################################################################

## Compilers
# https://help.ubuntu.com/community/InstallingCompilers
apt-get install build-essential -y
# gcc -v
# make -v

# Haskell
apt-get install ghc -y


# Ruby
apt-get install ruby -y

# Python stuff
apt-get install python3 python3-pip python3-setuptools python3-pyqt5 python3-dev libssl-dev -y

pip3 install --upgrade pip -y
pip3 install virtualenv -y

# Perl stuff
cpan install CPAN
cpan reload
cpan install Regexp::Common

# LAMP Stack


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

############################################################################
#### Editors
############################################################################

## Sublime
add-apt-repository ppa:webupd8team/sublime-text-2 -y
apt-get update
apt-get install sublime-text -y

## Vim
apt-get install vim -y
# install plugin manager, download my .vimrc, configure
gem install vim-update-bundles
wget https://raw.githubusercontent.com/mearlboro/settings/master/.vimrc -P ~/
vim-update-bundles
# nice fira fonts
mkdir -p ~/.local/share/fonts
for type in Bold Light Medium Regular Retina; do
    wget -O ~/.local/share/fonts/FiraCode-${type}.ttf \
    "https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true";
done
apt install powerline-fonts -y
fc-cache -vf

## Latex
apt-get install texlive -y
apt-get install texlive-latex-base -y


############################################################################
#### Shell
############################################################################

< /etc/shells grep zsh
apt install zsh -y
chsh -s /bin/zsh $(whoami)

# clone prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
# create new zsh config
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# update prezto
zprezto-update

# download my .zshrc
wget https://raw.githubusercontent.com/mearlboro/settings/master/.zshrc -P ~/

# download theme
mkdir ~/.zsh
cd ~/.zsh
git clone https://github.com/geometry-zsh/geometry
cd ~/.zsh/geometry
git submodule update --init --recursive
cd ~


############################################################################
#### Terminal
############################################################################

apt-get install tmux -y


############################################################################
#### Accessories
############################################################################

apt-get install nautilus -y

# archive
apt-get install unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller -y

# organize
apt install tree # tree view of files
# tree -L 2

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
wget https://protonmail.com/download/protonmail-bridge_1.0.3-1_amd64.deb
apt-get install debsig-verify debian-keyring
mkdir -p /usr/share/debsig/keyrings/E2C75D68E6234B07
gpg --dearmor --output /usr/share/debsig/keyrings/E2C75D68E6234B07/debsig.gpg bridge_pubkey.gpg
mkdir -p /etc/debsig/policies/E2C75D68E6234B07
cp bridge_16.04.pol /etc/debsig/policies/E2C75D68E6234B07
debsig-verify protonmail-bridge_1.0.3-1_amd64.deb
apt-get install ./protonmail-bridge_1.0.3-1_amd64.deb

# open MS office emails in linux
apt install libemail-outlook-message-perl libemail-sender-perl -y



################################################################################
#### Web
################################################################################

apt-get install whois -y

apt-get install filezilla -y

apt-get install openssh-server -y

apt-get install nmap -y

## VPN
apt-get install openvpn -y
apt-get install openvpn bridge-utils -y
apt-get install network-manager-openvpn network-manager-openvpn-gnome -y


## Browsers
add-apt-repository ppa:ubuntu-mozilla-daily/ppa
apt-get install firefox -y

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
apt-get update
apt-get install google-chrome-stable -y

add-apt-repository ppa:webupd8team/tor-browser
apt-get update
apt-get install tor-browser -y



############################################################################
#### Media and social
############################################################################

apt-get install vlc -y

apt-get install deluge -y # torrents

# Linphone - VOIP softphone
# apt install linphone -y
flatpak --user install --from https://linphone.org/flatpak/linphone.flatpakref

# Telegram
add-apt-repository ppa:atareao/telegram -y
apt-get update
apt-get install telegram -y

# Slack
apt-get install libcurl3 -y
wget -O slack.deb https://downloads.slack-edge.com/linux_releases/slack-desktop-3.0.2-amd64.deb
dpkg -i slack.deb
rm slack.deb

# Skype
wget -O skype.deb http://go.skype.com/skypeforlinux-64.deb
dpkg -i skype.deb
apt-get -f install -y
rm skype.deb

# Signal
curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
apt-get update
apt-get install signal-desktop -y


############################################################################
#### Virtualisation
############################################################################

# install from repository
# apt-get install virtualbox -y
# apt-get install virtualbox-dkms -y
# apt-get install virtualbox-qt -y
# apt-get install virtualbox-guest-utils -y

# set package sources
sh -c "echo 'deb http://download.virtualbox.org/virtualbox/debian '$(lsb_release -cs)' contrib' > /etc/apt/sources.list.d/virtualbox.list"
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -   # for linux mint 18
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O-      | apt-key add -

# install virtualbox
wget -O virtualbox.deb http://download.virtualbox.org/virtualbox/5.2.4/virtualbox-5.2_5.2.4-119785~Ubuntu~xenial_amd64.deb
dpkg -i virtualbox.deb


###
sudo reboot

