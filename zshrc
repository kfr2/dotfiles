# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
export PATH=$HOME/bin:/usr/local/share/npm/bin:$HOME/.rbenv/versions/1.9.3-p194/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Virtualenvwrapper setup.
export WORKON_HOME=~/Envs
export PROJECT_HOME=~/Developer
source /usr/local/bin/virtualenvwrapper_lazy.sh

# Allow bpython to load Django settings upon start (if available)
export PYTHONSTARTUP=~/.pythonrc

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
alias 'cls'='clear'
alias 'l'='ls -al'
alias 'ftu'='fab test update'
alias 'fpu'='fab prod update'
alias 'md'='make_dir_switch'
alias 'rs'='./manage.py runserver 0.0.0.0:$1'
alias 'v'='vagrant'
alias 'tmux'='TERM=screen-256color-bce tmux'
alias 'tmux-buffer-to-clipboard'='tmux save-buffer -|pbcopy'
alias 'tmux-buffer-from-clipboard'='tmux set-buffer "$(pbpaste)"'
alias 'tbt'='tmux-buffer-to-clipboard'
alias 'tbf'='tmux-buffer-from-clipboard'

# Add Z, the command jumper: https://github.com/rupa/z
source ~/bin/z.sh
function precmd () {
  _z --add "$(pwd -P)"
}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
