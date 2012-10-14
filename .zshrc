# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="blinks"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(django git hg mercurial pip python zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$HOME/bin:$HOME/.rvm/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin

# Load RVM environment and settings.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Virtualenvwrapper setup.
export WORKON_HOME=~/Envs
export PROJECT_HOME=~/Developer
source /usr/local/bin/virtualenvwrapper.sh

# Homebrew settings.
export BYOBU_PREFIX=`brew --prefix`

# Various settings.
export EDITOR="vim"
export ARCHFLAGS="-arch x86_64"


# Functions
function make_dir_switch() {
    mkdir $1 && cd $1
}

function server() {
    local port="${1:-8888}"
    open "http://localhost:${port}/"
    python -m SimpleHTTPServer "$port"
}

# Command aliases.
alias 'l'='ls -al'
alias 'cls'='clear'
alias 'tmux'='TERM=screen-256color-bce tmux'
alias 'ftu'='fab test update'
alias 'fpu'='fab prod update'
alias 'rs'='./manage.py runserver 0.0.0.0:8000'
alias 'v'='vagrant'
alias 'md'='make_dir_switch'
alias 'vim'='/Applications/MacVim.app/Contents/MacOS/Vim'

# Add Z
source ~/bin/z.sh
function precmd () {
  _z --add "$(pwd -P)"
}
