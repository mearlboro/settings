#!/bin/sh

# Must be ran by the current user

############################################################################
#### i3
############################################################################

mkdir ~/.config/i3
wget https://raw.githubusercontent.com/mearlboro/settings/master/i3/config        -P ~/.config/i3
wget https://raw.githubusercontent.com/mearlboro/settings/master/i3/brightness.sh -P ~/.config/i3
wget https://raw.githubusercontent.com/mearlboro/settings/master/i3/screenshot.sh -P ~/.config/i3
chmod +x ~/.config/i3/brightness.sh
chmod +x ~/.config/i3/screenshot.sh

# brightness requires sudo
echo "\n$(whoami) ALL=(root) NOPASSWD: /home/$(whoami)/.config/i3/brightness.sh" >> /etc/sudoers


############################################################################
#### shell & ssh
############################################################################

wget https://raw.githubusercontent.com/mearlboro/settings/master/.zshrc -P ~/
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


#############################################################################
#### vim
############################################################################

gem install vim-update-bundles
wget https://raw.githubusercontent.com/mearlboro/settings/master/.vimrc -P ~/
vim-update-bundles

## install powerline fonts
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir -p /usr/share/fonts/opentype/powerline
mv PowerlineSymbols.otf /usr/share/fonts/opentype/powerline
mv 10-powerline-symbols.conf /etc/fonts/conf.d/
fc-cache -vf /usr/share/fonts/opentype/powerline

