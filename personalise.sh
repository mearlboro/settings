#!/bin/sh

############################################################################
#### i3
############################################################################

mkdir ~/.config/i3
wget https://raw.githubusercontent.com/mearlboro/settings/master/i3/config        -P ~/.config/i3
wget https://raw.githubusercontent.com/mearlboro/settings/master/i3/brightness.sh -P ~/.config/i3
wget https://raw.githubusercontent.com/mearlboro/settings/master/i3/i3-scrot.sh   -P ~/.config/i3
chmod +x ~/.config/i3/brightness.sh

# brightness requires sudo
echo "\n$(whoami) ALL=(root) NOPASSWD:/home/$(whoami)/.config/i3/brightness.sh" | sudo tee -a /etc/sudoers

mkdir ~/.config/i3status
wget https://raw.githubusercontent.com/mearlboro/settings/master/i3/i3status -O ~/.config/i3status/config

############################################################################
#### shell & ssh
############################################################################

wget https://raw.githubusercontent.com/mearlboro/settings/master/.zshrc -P ~/

curl -fsSL https://starship.rs/install.sh | bash
wget https://raw.githubusercontent.com/mearlboro/settings/master/starship.tomp -P ~/.config/

mkdir -p ~/.zsh/fzf-tab/
git clone https://github.cm/Aloxaf/fzf-tab ~/.zsh/
source ~/.zshrc

mkdir -p ~/.ssh
wget https://raw.githubusercontent.com/mearlboro/settings/master/.ssh/config -P ~/.ssh

############################################################################
#### git
############################################################################

git config --global user.name "mis"
git config --global user.email "mearlboro@protonmail.com"
git config --global color.ui true
# don't show changes of permissions in diff
git config --global core.filemode false
# leave Windows line endings alone
git config --global core.autocrlf input
# always add your changes on top when pulling
git config --global branch.autosetuprebase always
# default merge tool
git config --global merge.tool meld


#############################################################################
#### vim
############################################################################

gem install vim-update-bundles
wget https://raw.githubusercontent.com/mearlboro/settings/master/.vimrc -P ~/
vim-update-bundles

#############################################################################
#### fonts
#
# https://www.nerdfonts.com/
# TODO: https://github.com/gabrielelana/awesome-terminal-fonts
############################################################################

sudo apt install fonts-dejavu fonts-dejavu-core fonts-dejavu-extra ttf-dejavu-core -y
sudo apt install libotf-bin -y

mkdir -p ~/.fonts

wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
wget https://www.cufonfonts.com/download/rf/fixedsys-excelsior-301 -O fixedsys.zip
unzip fixedsys.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Cousine.zip
unzip Cousine.zip
mv *.otf *.ttf ~/.fonts
sudo mv *.conf /etc/fonts/conf.d/

fc-cache -vr
