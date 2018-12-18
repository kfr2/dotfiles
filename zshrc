#!/usr/local/bin/zsh
export PATH=$HOME/bin:$HOME/.cargo/bin:$HOME/npm/bin:/usr/local/opt/go/libexec/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
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
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh" # This loads nvm
  nvm "$@"
}

# golang
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# Various settings.
export EDITOR="vim"
export ARCHFLAGS="-arch x86_64"
bindkey -e  # use emacs mode

##############################################################################
# History Configuration - from https://gist.github.com/matthewmccullough/787142
##############################################################################
HISTSIZE=5000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=5000               #Number of history entries to save to disk
#HISTDUP=erase               #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Command aliases.
source ~/dotfiles/aliases.sh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# add support for ctrl+o to open selected file in VS Code
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"


# From https://stackoverflow.com/a/26479426
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit && compinit

# Antibody packages
source <(antibody init)
antibody bundle < ~/dotfiles/zsh_plugins.txt

# Pure prompt
export PURE_PROMPT_SYMBOL=$

