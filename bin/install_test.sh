#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

function test_thing {
    echo "\n\n============================"
    echo "$1"
    echo "============================"
}

function message {
    echo "\n\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "$1"
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
}

message "Testing Dependenices"

test_thing "Git"
git --version

test_thing "nvim"
nvim --version | grep NVIM

test_thing "zsh"
zsh --version


message "Testing bootstrap Script"
/home/kryten/dotfiles/bin/bootstrap.sh


message "Testing installed stuff"
