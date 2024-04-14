export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="lambda"

plugins=(kubectl kubectx)
source $ZSH/oh-my-zsh.sh
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# alias vim='nvim'
alias vim="$HOME/nvim-nightly/nvim-macos/bin/nvim"
alias n='node --version'
alias tmux='env TERM=screen-256color tmux'
alias gs='git status'
gc() {
  git branch --sort=-committerdate | fzf | sed 's/^[*+ ]*//' | xargs -r git checkout
}
gw() {
  local dir=$(git worktree list | fzf | awk '{print $1}')
  if [[ -n $dir ]]; then
    cd "$dir" || return
  fi
}

bindkey '^f' forward-word
bindkey '^b' backward-word

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

set_eslint_flat_config() {
  if [[ -f "$PWD/eslint.config.js" ]]; then
    export ESLINT_USE_FLAT_CONFIG=true
  else
    unset ESLINT_USE_FLAT_CONFIG
  fi
}

set_worktree_name() {
  local git_root=$(git rev-parse --show-toplevel 2>/dev/null)
  local worktree_name=$(git worktree list 2>/dev/null | grep -i "$git_root" | awk -F'/' '{print $NF}' | awk '{print $1}')
  if [ -z "$worktree_name" ]; then
    unset GIT_WORKTREE
    return
  fi
  export GIT_WORKTREE="$worktree_name"
}

add-zsh-hook chpwd load-nvmrc
add-zsh-hook chpwd set_eslint_flat_config
add-zsh-hook chpwd set_worktree_name
load-nvmrc
set_eslint_flat_config
set_worktree_name

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

eval "$(jump shell zsh)"
eval "$(direnv hook zsh)"

# gcloud
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
