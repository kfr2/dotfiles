#!/usr/local/bin/zsh
export PATH=$HOME/bin:$HOME/bin/FlameGraph:$HOME/.cargo/bin:$HOME/npm/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export TERM=xterm-256color
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# python
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
export PYTHONUNBUFFERED="true"
export PYTHONDONTWRITEBYTECODE="true"

# pyenv & pyenv-virtualenv -- lazy-loaded
pyenv() {
  eval "$(command pyenv init -)"
  eval "$(command pyenv virtualenv-init -)"
  pyenv "$@"
}

# nvm -- lazy-loaded
nvm() {
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
  nvm "$@"
}

# golang
export GOPATH=$HOME/projects/go
export PATH=$GOPATH/bin:$PATH

# Various settings.
export EDITOR="vim"
export ARCHFLAGS="-arch x86_64"
bindkey -e  # use emacs mode

# Command aliases.
source ~/dotfiles/aliases.sh

# fzf
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh
# This alias is from https://remysharp.com/2018/08/23/cli-improved
alias preview="fzf --preview 'bat --color \"always\" {}'"
# add support for ctrl+o to open selected file in VS Code
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"


# From https://stackoverflow.com/a/26479426
autoload -U compinit && compinit

# Antibody packages
source <(antibody init)
antibody bundle < ~/dotfiles/zsh_plugins.txt

# Pure prompt
export PURE_PROMPT_SYMBOL=$
