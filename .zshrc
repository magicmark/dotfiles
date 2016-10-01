# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/dotfiles/custom_ohmyzsh
export DOTFILES=$HOME/dotfiles

ZSH_THEME="markl"
plugins=(git tmux vundle virtualenv)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin"

source $ZSH/oh-my-zsh.sh

export LC_ALL="en_US.UTF-8"

if [[ `uname` == 'Darwin' ]]; then
    export IS_OSX=1

    if [[ -e ~/.zshrc.osx ]]; then
        source ~/.zshrc.osx
    fi
elif [[ `uname` == 'Linux' ]]; then
    export IS_LINUX=1

    if [[ -e ~/.zshrc.linux ]]; then
        source ~/.zshrc.linux
    fi
fi

if [[ -e ~/.profile.zsh ]]; then
    source ~/.profile.zsh
else
    (>&2 echo "Could not find ~/.profile.zsh!")
fi

if [[ -e ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

if [[ -e ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
fi


export NVM_DIR="/home/mark/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
