# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Enable bash history
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

# These set up/down to do the history searching
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward


export EDITOR='vim'
export PAGER="less"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# use vi keybindings.
set -o vi

# color prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '


# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# enable programmable completion features
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

/usr/bin/keychain bpederse --quick
source ~/.keychain/`uname -n`-sh

