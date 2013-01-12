fpath=(~/.zsh/functions  $fpath)
fpath=(~/.zsh/completion $fpath)
setopt promptsubst
autoload -U promptinit
promptinit
prompt grb

autoload -U compinit
compinit
# Add paths that should have been there by default
export PATH=/usr/local/sbin:/usr/local/bin:${PATH}
export PATH="$HOME/bin:$PATH"

# automatically enter directories without cd
setopt auto_cd

# Try to correct command line spelling
setopt CORRECT CORRECT_ALL

if [ -f ~/.zsh_nocorrect ]; then
    while read -r COMMAND; do
        alias $COMMAND="nocorrect $COMMAND"
    done < ~/.zsh_nocorrect
fi

setopt EXTENDED_GLOB
# Unbreak broken, non-colored terminal
export TERM="xterm-256color"
alias ls='ls -G'
alias ll='ls -lG'
alias duh='du -csh'
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export GREP_OPTIONS="--color"

# Unbreak history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

export EDITOR=vim


autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

export WORDCHARS='*?[]~&;!$%^<>'

export ACK_COLOR_MATCH='red'

# ACTUAL CUSTOMIZATION OH NOES!
gd() { git diff $* | view -; }
gdc() { gd --cached $*; }

alias rbgrep="grep --include='*.rb' $*"
alias r=rails
alias sr="screen -r"
function mcd() { mkdir -p $1 && cd $1 }
function cdf() { cd *$1*/ } # stolen from @topfunky




# By @ieure; copied from https://gist.github.com/1474072
#
# It finds a file, looking up through parent directories until it finds one.
# Use it like this:
#
#   $ ls .tmux.conf
#   ls: .tmux.conf: No such file or directory
#
#   $ ls `up .tmux.conf`
#   /Users/grb/.tmux.conf
#
#   $ cat `up .tmux.conf`
#   set -g default-terminal "screen-256color"
#
function up()
{
    if [ "$1" != "" -a "$2" != "" ]; then
        local DIR=$1
        local TARGET=$2
    elif [ "$1" ]; then
        local DIR=$PWD
        local TARGET=$1
    fi
    while [ ! -e $DIR/$TARGET -a $DIR != "/" ]; do
        DIR=$(dirname $DIR)
    done
    test $DIR != "/" && echo $DIR/$TARGET
}

# restore previous cwd
if [[ -f ~/.last_cwd ]]; then
  cd `cat ~/.last_cwd`
fi
_save_last_cwd() {
  echo `pwd` > ~/.last_cwd
}
chpwd_functions=( "${chpwd_functions[@]}" _save_last_cwd )

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

