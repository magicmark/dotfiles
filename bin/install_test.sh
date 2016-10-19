#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

echo "Git Version:"
git --version

echo "nvim Version"
nvim --version | grep NVIM

echo "zsh version"
zsh --version
