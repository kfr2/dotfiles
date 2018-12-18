#!/bin/sh
# vim package manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# iterm
brew cask install iterm2

# zsh & package manager
brew install zsh
brew install getantibody/tap/antibody

# miscellaneous
brew install exa bat fd ncdu fzf ripgrep diff-so-fancy jq \
wget \
pyenv pyenv-virtualenv \
golang dep

# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
