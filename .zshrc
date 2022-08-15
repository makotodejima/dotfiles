# stty -ixon
export ZSH="/Users/makotodejima/.oh-my-zsh"
# export TERM=xterm-256color
ZSH_THEME="lambda"

plugins=(Z fzf-zsh zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/dev/lua-language-server/bin/macOS:$PATH"

# Postgres
PATH="$HOME/tools/lua-language-server/bin/macOS:/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

alias killbuild='lsof -i :3000 | grep node | head -n 1 | awk "{print \$2}" | xargs kill -9'
alias gs='git status'
alias vim='nvim'
alias n='node --version'

# vim fzf preview syntax highlighting
export BAT_THEME='base16'

eval "$(direnv hook zsh)"
eval "$(jump shell zsh)"
eval "$(mcfly init zsh)"
alias config='/usr/bin/git --git-dir=/Users/makotodejima/.cfg/ --work-tree=/Users/makotodejima'

alias luamake=/Users/makotodejima/dev/lua-language-server/3rd/luamake/luamake
export PATH="/usr/local/opt/mongodb-community@4.2/bin:$PATH"

