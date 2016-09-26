#!/bin/bash

if [ ! `which git` ]; then
    echo "Git is not installed - please install git!"
    exit 1;
fi


if [ ! `which nvim` ]; then
    echo "nvim is not installed - please install neovim!"
    exit 1;
fi


if [ ! `which zsh` ]; then
    echo "zsh is not installed - please install zsh!"
    exit 1;
fi


if [ ! -d "~/.oh-my-zsh" ]; then
    curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
fi

