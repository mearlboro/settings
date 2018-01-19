#!/bin/sh


############################################################################
# add basic repos to sources.list and update
echo "deb http://ftp.debian.org/debian sylvia main contrib non-free" | sudo tee -a /etc/apt/sources.list
apt-get update && apt-get upgrade

# kernel update utility
apt install ukuu


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
apt-get install ruby -y

# Python stuff
apt-get install python3 python3-pip python3-setuptools python3-pyqt5 -y
pip3 install --upgrade pip -y

# Perl stuff
cpan install CPAN
cpan reload

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
fc-cache -f

## Latex
apt-get install texlive -y
apt-get install texlive-latex-base -y


############################################################################
#### Shell
############################################################################

< /etc/shells grep zsh
apt install zsh
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

# email
apt-get install sendmail -y

add-apt-repository ppa:ubuntu-mozilla-security/ppa -y
apt-get update
apt-get install thunderbird -y

# open MS office emails in linux
apt install libemail-outlook-message-perl libemail-sender-perl

# organize
apt install tree # tree view of files
# tree -L 2


################################################################################
#### Web
################################################################################

apt-get install whois -y

apt-get install filezilla -y

apt-get install openssh-server -y

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
apt-get install google-chrome-stable


############################################################################
#### Media and social
############################################################################

apt-get install vlc -y

apt-get install deluge -y # torrents

# Linphone - VOIP softphone
apt install linphone

# Telegram
add-apt-repository ppa:atareao/telegram -y
apt-get update
apt-get install telegram -y

# Slack
apt-get install libcurl3
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
apt-get install signal-desktop


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

