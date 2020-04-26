# .bashrc

# Source global definitions
[ -f /etc/bashrc ] && source /etc/bashrc

# Load bash completions
. $HOME/.local/share/bash-completion/bash_completion

# Load Ruby Version Manager (RVM)
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Command aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

[ -n "$TERM" ] && alias htop='TERM=screen htop'

[ -f "$HOME/.local/bin/nginx-logs.sh" ] && alias nginx-logs="sudo $HOME/.local/bin/nginx-logs.sh"

export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

[ -n "$PS1" ] && \
  export PS1="\[\e[m\]\[\e[38;5;196m\]\A\[\e[m\] \[\e[38;5;245m\]\u\[\e[37m\]@\[\e[38;5;222m\]\H\[\e[37m\]:\[\e[38;5;33m\]\w\[\e[37m\]\\$\[\e[m\] "

[ -x /usr/bin/dircolors ] && [ -s ~/.dir_colors ] && eval "$(/usr/bin/dircolors ~/.dir_colors)"

# Shell history settings
export HISTCONTROL=ignoredups:erasedups # no duplicate entries
export HISTSIZE=50000                   # big history
export HISTFILESIZE=50000               # big history
shopt -s histappend                     # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"

# Set GPG TTY to current TTY if it's not already set
[ -z "$GPG_TTY" ] && export GPG_TTY=$(tty)

# Load Vultr rc file if it exists
[ -f $HOME/.vultrrc ] && . $HOME/.vultrrc

# Load PHP if it exists
[ ! -x php ] && [ -f /opt/remi/php74/enable ] && source /opt/remi/php74/enable
[ ! -x php ] && [ -f /opt/remi/php73/enable ] && source /opt/remi/php73/enable
[ ! -x php ] && [ -f /opt/remi/php72/enable ] && source /opt/remi/php72/enable
[ ! -x php ] && [ -f /opt/remi/php71/enable ] && source /opt/remi/php71/enable
[ ! -x php ] && [ -f /opt/remi/php70/enable ] && source /opt/remi/php70/enable
[ ! -x php ] && [ -f /opt/remi/php56/enable ] && source /opt/remi/php56/enable
