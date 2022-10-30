export ZSH="/Users/makotodejima/.oh-my-zsh"
# export TERM=xterm-256color
ZSH_THEME="lambda"

plugins=(zsh-autosuggestions kubectl kubectx)
source $ZSH/oh-my-zsh.sh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Postgres
PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

alias killbuild='lsof -i :3000 | grep node | head -n 1 | awk "{print \$2}" | xargs kill -9'
alias gs='git status'
alias vim='nvim'
alias n='node --version'

eval "$(direnv hook zsh)"
eval "$(jump shell zsh)"
alias config='/usr/bin/git --git-dir=/Users/makotodejima/.cfg/ --work-tree=/Users/makotodejima'

export PATH="/usr/local/opt/mongodb-community@4.2/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
