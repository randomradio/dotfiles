#!/usr/bin/env bash

# Function to install zoxide
install_zoxide() {
  if command -v zoxide >/dev/null 2>&1; then
    echo "zoxide is already installed."
    return 0
  fi

  if command -v brew >/dev/null 2>&1; then
    echo "Installing zoxide via Homebrew..."
    brew install zoxide
  else
    echo "Homebrew is required to install zoxide. Install Homebrew and re-run this script."
    return 1
  fi
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
  install_zoxide
  run_macos_setup
  echo "Setup complete!"
}

main
