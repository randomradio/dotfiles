#!/usr/bin/env bash
set -e

REPO="https://github.com/randomradio/dotfiles.git"
TEMP_DIR="$HOME/.dotfiles-tmp"

echo "Installing tmux and neovim configs..."

# Tmux - direct download (single files)
echo "→ Installing tmux config..."
curl -fsSL https://raw.githubusercontent.com/randomradio/dotfiles/main/tmux/.tmux.conf -o ~/.tmux.conf
curl -fsSL https://raw.githubusercontent.com/randomradio/dotfiles/main/tmux/.tmux.conf.local -o ~/.tmux.conf.local

# Neovim - sparse clone (folder structure)
echo "→ Installing neovim config..."
mkdir -p "$TEMP_DIR"
git clone --depth 1 --sparse --filter=blob:none --single-branch "$REPO" "$TEMP_DIR"
git -C "$TEMP_DIR" sparse-checkout set nvim
cp -r "$TEMP_DIR/nvim" ~/.config/
rm -rf "$TEMP_DIR"

# TPM (tmux plugin manager)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "→ Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "✓ Done! Run tmux and press prefix + I to install plugins."
