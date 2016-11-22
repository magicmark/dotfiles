#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

echo "[+] Running bootstrap script for user $(whoami)"

# -----------------------------------------------------------------------
#
# This will check for and install dependencies that the dotfiles rely on.
#
# -----------------------------------------------------------------------

if [ ! "$(which git)" ]; then
    echo "[+] Git is not installed - please install git!"
    exit 1;
fi


if [ ! "$(which nvim)" ]; then
    echo "[+] nvim is not installed - please install neovim!"
    exit 1;
fi


if [ ! "$(which zsh)" ]; then
    echo "[+] zsh is not installed - please install zsh!"
    exit 1;
fi


if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "[+] Installing oh-my-zsh..."

    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

    if [ -z "${IN_DOCKER_TEST:-}" ]; then
        # Change shell
        chsh -s "$(grep /zsh$ /etc/shells | tail -1)"
    fi
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
        git checkout "$(git describe --abbrev=0 --tags --match "v[0-9]*" origin)"
    )
else
    echo "[+] Skipping install of nvm"
fi


if [ ! -d "$HOME/.fzf" ]; then
    echo "[+] Installling fzf..."

    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
    "$HOME/.fzf/install" --completion  --key-bindings --no-update-rc
else
    echo "[+] Skipping install of fzf"
fi


# Install vim plugins
echo "[+] Installing vundle plugins"
nvim +PluginInstall +qall

# Make sure .ssh exists
mkdir -p ~/.ssh

# Ensure github.com is trusted
if ! grep -q github.com ~/.ssh/known_hosts; then
    echo "[+] Adding ssh key for github.com to known_hosts"
    ssh-keyscan github.com >> ~/.ssh/known_hosts
fi

# Install ~/GitApps
mkdir -p ~/GitApps

if [ "$(uname)" == 'Linux' ]; then
    git clone git@github.com:Yelp/aactivator.git ~/GitApps/aactivator
fi


# Optional dependencies to remind me about
if [ ! "$(which tmux)" ]; then
    echo "[+] Suggested - tmux is not installed - please install tmux!"
fi


if [ ! "$(which virtualenv)" ]; then
    echo "[+] Suggested - virtualenv is not installed - please install virtualenv!"
fi

echo "[+] All done!"
