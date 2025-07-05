#!/usr/bin/env bash

# Function to create symlinks
create_symlinks() {
    local dotfiles_dir="$HOME/dotfiles"
    local shell_dir="$dotfiles_dir/shell"

    # Zsh files
    ln -sfv "$shell_dir/.zshrc" "$HOME/.zshrc"
    ln -sfv "$shell_dir/.zprofile" "$HOME/.zprofile"
    ln -sfv "$shell_dir/.zshenv" "$HOME/.zshenv"

    # Other dotfiles
    # Example: ln -sfv "$dotfiles_dir/.gitconfig" "$HOME/.gitconfig"
    ln -sfv "$dotfiles_dir/tmux/.tmux.conf" "$HOME/.tmux.conf"
    ln -sfv "$dotfiles_dir/tmux/.tmux.conf.local" "$HOME/.tmux.conf.local"
    ln -sfv "$dotfiles_dir/nvim" "$HOME/.config/nvim"
}

# Function to run macOS setup
run_macos_setup() {
    local macos_script="$HOME/dotfiles/.macos"
    if [ -f "$macos_script" ]; then
        echo "Running macOS setup..."
        bash "$macos_script"
    else
        echo "macOS setup script not found."
    fi
}

# Main function
main() {
    echo "Setting up your development environment..."
    create_symlinks
    run_macos_setup
    echo "Setup complete!"
}

main
