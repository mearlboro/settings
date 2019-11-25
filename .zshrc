export TERM="xterm-256color"

###############################################################################
## Autocomplete
###############################################################################

autoload -Uz compinit
compinit
# generate descriptions for auto completion
zstyle ':completion:*' auto-description 'specify: %d'
# allows navigation through options with arrow keys
zstyle ':completion:*' menu yes select
zstyle ':completion:*:*:cd:*' menu yes select

unsetopt LIST_AMBIGUOUS
setopt  COMPLETE_IN_WORD


###############################################################################
## Options
###############################################################################

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


###############################################################################
## Aliases
###############################################################################

# shell
alias ls='ls -CF'  # Make ls display in columns and with a file type indicator by default
alias ll='ls -lhA' # display hidden files in long format, omit current and parent, human readable sizes
alias mkdir='mkdir -pv' # create parent dirs, visually

# always ssh with agent forwarding
alias ssh='ssh -A'

# system
alias ps='ps auxf' # process list in detail

# find, replace
alias hgrep='history | grep'
# searches by process name, excluding this command
alias psgrep='ps aux | grep -v grep | grep -i -e VSZ -e'

# configure monitors
alias xrandrfix='xrandr --setprovideroutputsource'

# always whois without legal disclaimer
alias whois='whois -H'

alias zshrc='vim ~/.zshrc'
alias zshsrc='source ~/.zshrc'
alias vimrc='vim ~/.vimrc'
alias i3conf='vim ~/.config/i3/config'
alias pvpn='sudo protonvpn'

# type 'dir' instead of 'cd dir'
setopt AUTO_CD

## Shortcuts
###############################################################################

# Alt-S inserts 'sudo' at beginning of line
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo


###############################################################################
## Theme
###############################################################################
source ~/.zsh/themes/powerlevel9k/powerlevel9k.zsh-theme

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
## Quick
###############################################################################

# type ~name to access directory
hash -d dl=~/Downloads
