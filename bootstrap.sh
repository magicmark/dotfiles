#!/bin/bash

# -----------------------------------------------------------------------
#
# This will check for and install dependencies that the dotfiles rely on.
#
# -----------------------------------------------------------------------

set -e

if [ ! `which git` ]; then
    echo "[+] Git is not installed - please install git!"
    exit 1;
fi


if [ ! `which nvim` ]; then
    echo "[+] nvim is not installed - please install neovim!"
    exit 1;
fi


if [ ! `which zsh` ]; then
    echo "[+] zsh is not installed - please install zsh!"
    exit 1;
fi


if [ ! -d ~/.oh-my-zsh ]; then
    echo "[+] Installing oh-my-zsh..."

    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    chsh -s $(grep /zsh$ /etc/shells | tail -1)
else
    echo "[+] Skipping install of oh-my-zsh"
fi

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    echo "[+] Installing Vundle..."

    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
    echo "[+] Skipping install of Vundle"
fi

if [ ! -d ~/.nvm ]; then
    echo "[+] Installing nvm..."

    export NVM_DIR="$HOME/.nvm" && (
        git clone https://github.com/creationix/nvm.git "$NVM_DIR"
        cd "$NVM_DIR"
        git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin`
    ) && . "$NVM_DIR/nvm.sh"
else
    echo "[+] Skipping install of nvm"
fi

echo "[+] All done!"
