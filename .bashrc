# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ $UID -eq 0 ]; then
  alias rm='rm -i'
  alias cp='cp -i'
  alias mv='mv -i'
fi

[ "$TERM" ] && alias htop='TERM=screen htop'

export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
[ "$PS1" ] && export PS1="\[$(tput sgr0)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\w\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

# Shell history settings
export HISTCONTROL=ignoredups:erasedups # no duplicate entries
export HISTSIZE=10000                   # big history
export HISTFILESIZE=10000               # big history
shopt -s histappend                     # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"
