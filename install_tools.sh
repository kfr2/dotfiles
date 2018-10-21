#!/bin/sh
# vim package manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# zsh package manager
yaourt -S antibody

# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# miscellaneous
sudo pacman -Sy exa bat fd ncdu fzf ripgrep diff-so-fancy jq

# vscode
yaourt -S visual-studio-code-bin
