set -o vi
# Fix for backspace in vi mode (?)
bindkey -v '^?' backward-delete-char

export HOMEBREW_PREFIX="$(brew --prefix)"
export EDITOR=nvim

export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

alias vim='nvim'
alias c='claude'
alias tmux='env TERM=screen-256color tmux'
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

source <(fzf --zsh)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# jump
eval "$(jump shell zsh)"

# direnv
eval "$(direnv hook zsh)"

# pnpm
export PNPM_HOME="/Users/makotodejima/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Go
export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin

# PostgreSQL
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# tz
export TZ_LIST="America/Los_Angeles;Europe/Berlin;Asia/Tokyo"

# IA Writer
export IA_TEMP_PATH="$HOME/Library/Mobile Documents/27N4MQEA55~pro~writer/Documents/temp"
export IA_LLM_PATH="$HOME/Library/Mobile Documents/27N4MQEA55~pro~writer/Documents/llm"

# . "$HOME/.local/bin/env"
export PATH="$HOME/.local/bin:$PATH"

# Added by Obsidian
export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"

eval "$(starship init zsh)"
