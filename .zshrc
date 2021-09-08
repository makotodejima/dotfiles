export ZSH="/Users/makotodejima/.oh-my-zsh"
export TERM=xterm-256color
ZSH_THEME="lambda"
plugins=(Z fzf-zsh zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Postgres
PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

alias killbuild='lsof -i :3000 | grep node | head -n 1 | awk "{print \$2}" | xargs kill -9'
alias gs='git status'
alias vim='nvim'

# vim fzf preview syntax highlighting
export BAT_THEME='base16'

eval "$(direnv hook zsh)"
eval "$(jump shell zsh)"
alias config='/usr/bin/git --git-dir=/Users/makotodejima/.cfg/ --work-tree=/Users/makotodejima'
