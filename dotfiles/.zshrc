# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/dotfiles/custom_ohmyzsh
export DOTFILES=$HOME/dotfiles/dotfiles

ZSH_THEME="markl"
plugins=(git tmux vundle virtualenv)

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin"
source $ZSH/oh-my-zsh.sh
export LC_ALL="en_US.UTF-8"

source $DOTFILES/.profile.zsh

if [[ `uname` == 'Darwin' ]]; then
    export IS_OSX=1
    source $DOTFILES/.zshrc.osx
elif [[ `uname` == 'Linux' ]]; then
    export IS_LINUX=1
    source $DOTILFES/.zshrc.linux
fi

if [[ -e ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

if [[ -e ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
fi
