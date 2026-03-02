#!/bin/bash

C='\033[38;5;245m'
C0='\033[0m'

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // .model.id // "?"')
cwd=$(echo "$input" | jq -r '.cwd // empty')
dir=$(basename "$cwd" 2>/dev/null || echo "?")

# Git status
git_info=""
if [[ -n "$cwd" && -d "$cwd" ]]; then
  branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
  if [[ -n "$branch" ]]; then
    staged=$(git -C "$cwd" diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
    modified=$(git -C "$cwd" diff --numstat 2>/dev/null | wc -l | tr -d ' ')
    untracked=$(git -C "$cwd" ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')

    changes=""
    [ "$staged" -gt 0 ] && changes="+${staged}"
    [ "$modified" -gt 0 ] && changes="${changes}~${modified}"
    [ "$untracked" -gt 0 ] && changes="${changes}?${untracked}"

    sync=""
    upstream=$(git -C "$cwd" rev-parse --abbrev-ref @{upstream} 2>/dev/null)
    if [[ -n "$upstream" ]]; then
      counts=$(git -C "$cwd" rev-list --left-right --count HEAD...@{upstream} 2>/dev/null)
      ahead=$(echo "$counts" | cut -f1)
      behind=$(echo "$counts" | cut -f2)
      [ "$ahead" -gt 0 ] && sync=">${ahead}"
      [ "$behind" -gt 0 ] && sync="${sync}<${behind}"
    fi

    git_info=" | ${branch}${changes:+ ${changes}}${sync:+ ${sync}}"
  fi
fi

# Context usage
pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
max_k=$(($(echo "$input" | jq -r '.context_window.context_window_size // 200000') / 1000))
filled=$((pct * 10 / 100))
empty=$((10 - filled))
bar=""
[ "$filled" -gt 0 ] && bar=$(printf "%${filled}s" | tr ' ' '▓')
[ "$empty" -gt 0 ] && bar="${bar}$(printf "%${empty}s" | tr ' ' '░')"

printf '%b\n' "${C}${model} | ${dir}${git_info} | ${bar} ${pct}% of ${max_k}k${C0}"
