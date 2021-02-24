# Setup a red prompt for root and a green one for users.
# rename this file to color_prompt.sh to actually enable it
NORMAL="\[\e[0m\]"
RED="\[\e[1;31m\]"
BLUE="\[\033[01;34m\]"
YELLOW="\[\e[1;33m\]"
GREEN="\[\e[1;32m\]"
if [ "$(id -u)" = 0 ]; then
	PS1="$RED\h [$NORMAL\w$RED]# $NORMAL"
else
	PS1="$GREEN\h [$NORMAL\w$GREEN]\$ $NORMAL"
fi

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
