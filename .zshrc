# Path to oh-my-zsh installation.
export ZSH="/Users/makotodejima/.oh-my-zsh"
export TERM=xterm-256color
ZSH_THEME="lambda"
plugins=(Z fzf-zsh zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Load NVM
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh

# yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Postgres
PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# direnv
eval "$(direnv hook zsh)"

# alias
alias killbuild='lsof -i :3000 | grep node | head -n 1 | awk "{print \$2}" | xargs kill -9'
