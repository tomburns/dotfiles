if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

export PATH=$HOME/bin:$PATH
export CC=gcc-4.2
export EDITOR=mvim

### COLORS ###
          RED="\[\033[0;31m\]"
    LIGHT_RED="\[\033[1;31m\]"
       YELLOW="\[\033[1;33m\]"
       ORANGE="\[\033[0;33m\]"
         BLUE="\[\033[0;34m\]"
   LIGHT_BLUE="\[\033[1;34m\]"
        GREEN="\[\033[0;32m\]"
  LIGHT_GREEN="\[\033[1;32m\]"
         CYAN="\[\033[0;36m\]"
   LIGHT_CYAN="\[\033[1;36m\]"
       PURPLE="\[\033[0;35m\]"
 LIGHT_PURPLE="\[\033[1;35m\]"
        WHITE="\[\033[1;37m\]"
   LIGHT_GRAY="\[\033[0;37m\]"
        BLACK="\[\033[0;30m\]"
         GRAY="\[\033[1;30m\]"
     NO_COLOR="\[\e[0m\]"

export CLICOLOR=1

export PS1="${GREEN}\u@\h${WHITE}:${CYAN}\w ${NO_COLOR}\$ "

[[ -s "/Users/tburns/.rvm/scripts/rvm" ]] && source "/Users/tburns/.rvm/scripts/rvm"
