alias rebuild='nh os switch'
alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='ls -la'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias cd='z'
alias cat='bat'

try() {
  if [ $# -eq 0 ]; then
    echo "usage: try <pkg> [pkg...]   (ephemeral nix shell, nothing installed)" >&2
    return 1
  fi
  local specs=() p
  for p in "$@"; do specs+=("nixpkgs#$p"); done
  nix shell "${specs[@]}"
}

update() {
  echo "==> nix packages"
  (cd ~/nixos && nh os switch -u)
  echo "==> firmware"
  fwupdmgr refresh && fwupdmgr update
  echo "==> done"
}

cleanup-game-saves() {
  echo "==> Ren'Py"; rm -rf ~/.renpy/* 2>/dev/null
  echo "==> Unity";  rm -rf ~/.config/unity3d/* ~/.local/share/unity3d/* 2>/dev/null
  echo "==> Godot";  rm -rf ~/.local/share/godot/* 2>/dev/null
}

SHUSH_FILTER="prisma:warn|Please manually install OpenSSL"
shush() {
  emulate -L zsh
  "$@" 2> >(grep --line-buffered -vE "$SHUSH_FILTER" >&2)
}
for _pm in yarn npm npx pnpm bun bunx; do
  functions[$_pm]='command '"$_pm"' "$@" 2> >(grep --line-buffered -vE "$SHUSH_FILTER" >&2)'
done
unset _pm

autoload -Uz add-zsh-hook

_skip_history() {
  emulate -L zsh
  [[ "$PWD" == "$HOME/Games" || "$PWD" == "$HOME/Games"/* ]] && return 1
  return 0
}
add-zsh-hook zshaddhistory _skip_history

_direnv_hook() {
  trap -- "" SIGINT
  eval "$(direnv export zsh 2> >( grep -vE 'direnv: (loading|using|export)|nix-direnv:|Renewed cache|cache invalidated' >&2 ))"
  trap - SIGINT
}
add-zsh-hook precmd _direnv_hook
add-zsh-hook chpwd _direnv_hook

export _ZO_DOCTOR=0
eval "$(zoxide init zsh)"
