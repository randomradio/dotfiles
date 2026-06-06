#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ "${1:-}" = "--macos-defaults" ]; then
  "$repo_dir/macos-defaults.sh"
  exit 0
fi

link_file() {
  local source_path="$1"
  local target_path="$2"

  mkdir -p "$(dirname "$target_path")"

  if [ -L "$target_path" ] && [ "$(readlink "$target_path")" = "$source_path" ]; then
    echo "ok: $target_path"
    return
  fi

  if [ -e "$target_path" ] || [ -L "$target_path" ]; then
    local backup_path="${target_path}.bak.$(date +%Y%m%d%H%M%S)"
    mv "$target_path" "$backup_path"
    echo "backup: $target_path -> $backup_path"
  fi

  ln -s "$source_path" "$target_path"
  echo "link: $target_path -> $source_path"
}

echo "Linking dotfiles from $repo_dir"

link_file "$repo_dir/shell/.zshrc" "$HOME/.zshrc"
link_file "$repo_dir/shell/.zprofile" "$HOME/.zprofile"
link_file "$repo_dir/shell/.zshenv" "$HOME/.zshenv"
link_file "$repo_dir/tmux/.tmux.conf" "$HOME/.tmux.conf"
link_file "$repo_dir/tmux/.tmux.conf.local" "$HOME/.tmux.conf.local"
link_file "$repo_dir/nvim" "$HOME/.config/nvim"
link_file "$repo_dir/ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
link_file "$repo_dir/gitignore_global" "$HOME/.gitignore_global"

git config --global core.excludesfile "$HOME/.gitignore_global"

echo "Done."
