# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export PATH=~/bin:~/usr/local/bin:$PATH

export EDITOR="vim"
export ARCHFLAGS="-arch x86_64"

alias 'docker-time'='dm start dev && eval "$(dm env dev)"'
alias 'docker-stop'='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

powerline-daemon -q
. /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

. /usr/local/bin/virtualenvwrapper_lazy.sh

. ~/bin/z
function precmd () {
  _z --add "$(pwd -P)"
}

