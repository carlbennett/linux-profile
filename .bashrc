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

if [ -f "/bin/firewall-cmd" ]; then
  deny_ip_remove() {
    [ "$1" == "" ] && printf "\033[1;31mYou must specify an IP address to unblock.\033[0;0m\n" && return 1
    /usr/bin/sudo /bin/firewall-cmd --zone="public" --remove-rich-rule="rule family='ipv4' source address='$1' drop" &&
    /usr/bin/sudo /bin/firewall-cmd --permanent --zone="public" --remove-rich-rule="rule family='ipv4' source address='$1' drop" 1>/dev/null
  }
  alias firewall-denyr=deny_ip_remove
  deny_ip_add() {
    [ "$1" == "" ] && printf "\033[1;31mYou must specify an IP address to block.\033[0;0m\n" && return 1
    /usr/bin/sudo /bin/firewall-cmd --zone="public" --add-rich-rule="rule family='ipv4' source address='$1' drop" &&
    /usr/bin/sudo /bin/firewall-cmd --permanent --zone="public" --add-rich-rule="rule family='ipv4' source address='$1' drop" 1>/dev/null
  }
  alias firewall-deny=deny_ip_add
elif [ -f "/usr/sbin/csf" ]; then
  deny_ip_remove() {
    [ "$1" == "" ] && printf "\033[1;31mYou must specify an IP address to unblock.\033[0;0m\n" && return 1
    /usr/bin/sudo /usr/sbin/csf -dr $1
  }
  alias firewall-denyr=deny_ip_remove
  deny_ip_add() {
    [ "$1" == "" ] && printf "\033[1;31mYou must specify an IP address to block.\033[0;0m\n" && return 1
    /usr/bin/sudo /usr/sbin/csf -d $1
  }
  alias firewall-deny=deny_ip_add
fi

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
