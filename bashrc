#!/bin/bash

ulimit -c 0

export PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local"
export PATH="/usr/local/bin:${PATH}"
export PATH="${HOME}/.local/bin:${PATH}"
export PATH=":~/Scripts:${PATH}"

export LD_LIBRARY_PATH="/usr/local/mesa/lib:/usr/local/lib:${LD_LIBRARY_PATH}"

export LOCALE="en_GB.utf8"

export EDITOR='nvim'
export HISTSIZE=500000
export MAIL="/u/all/${USER}/mail/${USER}"
export PAGER='less'
export PS1="(\h \#)"
export SAVEHIST=500000
export WATCH='all'

# ls and friends
alias ls='clear;lsd --color=auto'
alias kk='ll'
alias mm='ll'
alias k='l'
alias m='l'
alias ll='ls -l'
alias l='ll -h'
alias la='ls -la'
alias lr='ll -R'
alias ..l='..;l'
alias lcd='cd'
alias ..='cd ..'

# Binutils
alias rm='rm -v'
alias cp='cp -v'
alias mv='mv -v'

# Development
alias ne='nvim'
alias mak='make'
alias naje='make'
alias clean='make clean'
alias fclean='make fclean'
alias re='clean && make'
alias valgrindf='valgrind --leak-check=full --show-reachable=yes --track-origins=yes --num-callers=500'
alias jefaisducacaavecgit='grv' #'gitk --all &'

# Bashrc
alias anew='source ~/.bashrc'
alias bashrc='ne ~/.bashrc ; anew'

# Misc
alias mysql='mycli'
alias explore='fzf --preview "bat --style=numbers --color=always {}" | head -500'

function ytdl {
if [ 1 -gt "$#" ]
then
  echo "ytdl <link>"
else
  youtube-dl -x --audio-format mp3 $@
fi
}

function nbc() {
  ninja $@
  # ninja  $@ | colout -t ninja | colout -t g++
  # ret=${PIPESTATUS[0]}
  # if [ "$ret" -eq 0 ]
  # then
  #   play ~/Sounds/Spider_Solitaire_Win.mp3
  # else
  #   play ~/Sounds/Spider_Solitaire_Lose.mp3
  # fi
  #
  # return ${ret}
}

function carre() {
  echo -e "$@" | sed -e "s/ /  /g" | \
    sed -e "s/\\([a-z]\\)/:regional_indicator_\\1: /g" | \
    sed -e "s/0/:zero: /g" | \
    sed -e "s/1/:one: /g" |\
    sed -e "s/2/:two: /g" | \
    sed -e "s/3/:three: /g" | \
    sed -e "s/4/:four: /g" | \
    sed -e "s/5/:five: /g" | \
    sed -e "s/6/:six: /g" | \
    sed -e "s/7/:seven: /g" | \
    sed -e "s/8/:eight: /g" | \
    sed -e "s/9/:nine: /g"
}

[ -f ~/.bashrc.local ] && source ~/.bashrc.local
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f /usr/share/bash-completion/completions/git ] && source /usr/share/bash-completion/completions/git
