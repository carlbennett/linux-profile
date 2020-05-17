# .bash_aliases

alias ..='cd ..' # Lazier
alias cd..='cd ..' # Lazy
alias cp='cp -i' # Interactive cp
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias mv='mv -i' # Interactive mv
alias rm='rm -i' # Interactive rm
alias xzegrep='xzegrep --color=auto'
alias xzfgrep='xzfgrep --color=auto'
alias xzgrep='xzgrep --color=auto'
alias zegrep='zegrep --color=auto'
alias zgrep='zgrep --color=auto'
alias ~='cd ~' # Change directory to home faster

[ -n "$TERM" ] && alias htop='TERM=screen htop'
[ -f "$HOME/.local/bin/nginx-logs.sh" ] && alias nginx-logs="sudo $HOME/.local/bin/nginx-logs.sh"
