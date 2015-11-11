# .bashrc

# Source global definitions
[ -f /etc/bashrc ] && . /etc/bashrc

# Load bash completions
. $HOME/.local/share/bash-completion/bash_completion

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

[ -n "$TERM" ] && alias htop='TERM=screen htop'

[ -f "$HOME/.local/bin/nginx-logs.sh" ] && alias nginx-logs='sudo $HOME/.local/bin/nginx-logs.sh'

if [ -f "/bin/firewall-cmd" ] || [ -f "/usr/sbin/csf" ]; then
  deny_ip_add() {
    [ "$1" == "" ] && printf "\033[1;31mYou must specify an IP address to block.\033[0;0m\n" && return 1
    [ -f "/bin/firewall-cmd" ] &&
      /usr/bin/sudo /bin/firewall-cmd --zone="drop" --add-source="$1" &&
      /usr/bin/sudo /bin/firewall-cmd --permanent --zone="drop" --add-source="$1" 1>/dev/null
    [ -f "/usr/sbin/csf" ] &&
      /usr/bin/sudo /usr/sbin/csf -d "$1"
  }
  deny_ip_remove() {
    [ "$1" == "" ] && printf "\033[1;31mYou must specify an IP address to unblock.\033[0;0m\n" && return 1
    [ -f "/bin/firewall-cmd" ] &&
      /usr/bin/sudo /bin/firewall-cmd --zone="drop" --remove-source="$1" &&
      /usr/bin/sudo /bin/firewall-cmd --permanent --zone="drop" --remove-source="$1" 1>/dev/null
    [ -f "/usr/sbin/csf" ] &&
      /usr/bin/sudo /usr/sbin/csf -dr "$1"
  }
  alias firewall-deny=deny_ip_add
  alias firewall-denyr=deny_ip_remove
fi

export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

[ -n "$PS1" ] && \
  export PS1="\[$(tput sgr0)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\w\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

[ -x /usr/bin/dircolors ] && [ -s ~/.dir_colors ] && eval "$(/usr/bin/dircolors ~/.dir_colors)"

# Shell history settings
export HISTCONTROL=ignoredups:erasedups # no duplicate entries
export HISTSIZE=10000                   # big history
export HISTFILESIZE=10000               # big history
shopt -s histappend                     # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"
