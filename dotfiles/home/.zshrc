# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Path for dotfiles stuf
export DF_ROOT="$HOME/dotfiles"
export DOTFILES="$DF_ROOT/dotfiles"
export DHOME="$DOTFILES/home"

export ZSH_CUSTOM="$DOTFILES/custom_ohmyzsh"

ZSH_THEME="markl"

plugins=(git tmux vundle virtualenv zsh_reload)

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin"
source "$ZSH/oh-my-zsh.sh"
export LC_ALL="en_US.UTF-8"

source $DOTFILES/etc/.profile.zsh

if [[ `uname` == 'Darwin' ]]; then
    export IS_OSX=1
    source $DOTFILES/etc/.zshrc.osx
elif [[ `uname` == 'Linux' ]]; then
    export IS_LINUX=1
    source $DOTFILES/etc/.zshrc.linux
fi

source $DOTFILES/etc/.docker.zsh

if [[ -e ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

if [[ -e ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
fi
