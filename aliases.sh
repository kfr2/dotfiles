#!/bin/sh
alias 'cls'='clear'
alias 'l'='ls -lah'
alias 'ls'='exa'
alias 'tree'='tree -L 2'
alias 'gc'='git commit --verbose'
alias 'gca'='git commit --verbose --amend'
alias 'gg'='git grep'
alias 'grc'='git rebase --continue'
alias 'grbi'='git rebase -i master'
alias 'grbis'='git rebase -i staging'

alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"

# This alias is from https://remysharp.com/2018/08/23/cli-improved
alias preview="fzf --height 40% --preview 'if file -i {}|grep -q binary; then file -b {}; else bat --color \"always\" --line-range :40 {}; fi'"

alias 'd'='docker'
alias 'dc'='docker-compose'
alias 'dcx'='docker-compose exec'
alias 'dps'='docker ps -a'

