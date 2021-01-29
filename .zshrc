###############################################################################
## Options
###############################################################################

export TERM="xterm-256color"

# pipe to multiple outputs
setopt MULTIOS

# Spell check commands
setopt CORRECT

# 10 second wait on 'rm *'
setopt RM_STAR_WAIT

# use magic
setopt ZLE
setopt NO_HUP
setopt VI

# Editor
export EDITOR="vim"
setopt IGNORE_EOF

# type 'dir' instead of 'cd dir'
setopt AUTO_CD


###############################################################################
## Aliases & hashes
###############################################################################

# shell
alias ls='exa -al' # ls replaced with exa, which is faster and in colour

alias mkdir='mkdir -pv' # create parent dirs, visually

# always ssh with agent forwarding
alias ssh='ssh -A'

# system
alias ps='ps auxf' # process list in detail

# find, replace
alias hgrep='history | grep'
# searches by process name, excluding this command
alias psgrep='ps aux | grep -v grep | grep -i -e VSZ -e'
alias grep='grep --color'

# always whois without legal disclaimer
alias whois='whois -H'

# copy stdout to visual clipboard
alias clip='xclip -selection clipboard'

# screen brightness
alias linc='~/.config/i3/brightness.sh --inc'
alias ldec='~/.config/i3/brightness.sh --dec'
lit () { sudo bash -c "echo $1 > /sys/class/backlight/intel_backlight/brightness" }

# git aliases
git config --global alias.adog 'log --all --decorate --oneline --graph'
git config --global alias.last 'log -1 HEAD'
git config --global alias.undo 'reset --soft HEAD~'

# yubikey
alias copy_ykey="ssh-add -L | clip"
alias unlock_ykey="ssh-add -e /usr/lib/x86_64-linux-gnu/libykcs11.so; ssh-add -s /usr/lib/x86_64-linux-gnu/libykcs11.so"

# other
alias zshrc='vim ~/.zshrc'
alias zshsrc='source ~/.zshrc'
alias vimrc='vim ~/.vimrc'
alias i3conf='vim ~/.config/i3/config'

alias pvpn='sudo protonvpn'
alias pvpnr='pvpn d && pvpn c -f'

# type ~name to access directory
hash -d dl=/home/$(whoami)/Downloads
hash -d c=/home/$(whoami)/code


###############################################################################
## Shortcuts
###############################################################################

# Alt-S inserts 'sudo' at beginning of line
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo


###############################################################################
## Other
###############################################################################

# Draw a Mandelbrot!
function mandelbrot {
   local lines columns colour a b p q i pnew
   ((columns=COLUMNS-1, lines=LINES-1, colour=0))
   for ((b=-1.5; b<=1.5; b+=3.0/lines)) do
       for ((a=-2.0; a<=1; a+=3.0/columns)) do
           for ((p=0.0, q=0.0, i=0; p*p+q*q < 4 && i < 32; i++)) do
               ((pnew=p*p-q*q+a, q=2*p*q+b, p=pnew))
           done
           ((colour=(i/4)%8))
            echo -n "\\e[4${colour}m "
        done
        echo
    done
}


###############################################################################
## SSH
# http://mah.everybody.org/docs/ssh
###############################################################################

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
     echo "Initialising new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
     echo succeeded
     chmod 600 "${SSH_ENV}"
     . "${SSH_ENV}" > /dev/null
     /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     ps -e | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
         start_agent;
     }
else
     start_agent;
fi



###############################################################################
## Path
###############################################################################
export GEM_HOME="/home/share/gems"
export PATH="/home/share/gems/bin:$PATH"
export PATH="/home/share/appimg:$PATH"

## fzf
source ~/.zsh/fzf-tab/fzf-tab.plugin.zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh
