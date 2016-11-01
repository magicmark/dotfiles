#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

function test_thing {
    echo -e "\n\n------------------------------------"
    echo "Test: $1"
    echo "------------------------------------"
}

function message {
    echo -e "\n\n####################################"
    echo "$1"
    echo "####################################"
}

message "Testing Assumed Dependenices"

test_thing "Git"
git --version

test_thing "nvim"
nvim --version | grep NVIM

test_thing "zsh"
zsh --version


message "Running bootstrap Script"
/usr/bin/expect <<EOF
spawn /home/kryten/dotfiles/bin/bootstrap.sh
expect "Password"
send


message "Testing installed stuff"

test_thing
message "✓ Testing was successful!"
