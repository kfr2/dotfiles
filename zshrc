# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export PATH=~/bin:~/usr/local/bin:$PATH

export EDITOR="vim"
export ARCHFLAGS="-arch x86_64"
export BYOBU_PREFIX=`brew --prefix`

alias 'cls'='clear'
alias 'l'='ls -lah'
alias 'tree'='tree -L 2'

alias 'dm'='docker-machine'
alias 'docker-on'='dm start dev && eval "$(dm env dev)"'
alias 'docker-off'='export DOCKER_HOST='
alias 'dl'='docker ps -l -q'  # shows ID of last run container
alias 'docker-stop'='docker stop $(docker ps -a -q)'
alias 'docker-rm-stopped'='docker rm $(docker ps -a -q)'
alias 'docker-rm-all'='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

powerline-daemon -q
. /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

. ~/bin/z
function precmd () {
  _z --add "$(pwd -P)"
}

. ~/bin/git.plugin.zsh
. ~/bin/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

