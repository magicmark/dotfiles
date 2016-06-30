# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin"

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'

if [[ `uname` == 'Darwin' ]]; then
    export IS_OSX=1

    if [[ -e ~/.zshrc.osx ]]; then
        source ~/.zshrc.osx
    fi
fi

if [[ -e ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi
