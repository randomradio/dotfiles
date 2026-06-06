# Repository Guidelines

## Project Structure & Module Organization
Neovim configuration lives in `nvim/` with entrypoint `init.lua` and plugin modules under `lua/`. Formatter settings sit in `nvim/stylua.toml`. Shell profiles (`.zshrc`, `.zprofile`, `.zshenv`) are kept in `shell/`. Tmux dotfiles reside in `tmux/.tmux.conf` and `.tmux.conf.local`. Terminal defaults are tracked in `ghostty/config`. The root `install.sh` links these files into `$HOME`; `macos-defaults.sh` applies conservative macOS preferences when run explicitly; `gitignore_global` applies globally when linked.

## Build, Test, and Development Commands
Run `./install.sh` to symlink dotfiles into `$HOME`; rerun after changes to refresh links. Apply macOS defaults explicitly with `./install.sh --macos-defaults`. Use `tmux source-file ~/.tmux.conf` to apply tmux updates on demand. Validate Neovim plugins with `nvim --headless "+Lazy sync" +qa`. Regenerate plugin lock files via `nvim --headless "+Lazy lock" +qa`.

## Coding Style & Naming Conventions
Lua files use spaces with width 2 and maximum line width 120, matching `stylua.toml`; format with `stylua --config nvim/stylua.toml nvim/lua`. Name new Lua modules in `snake_case.lua` and expose them via `require("user.module")`. Shell scripts target `/usr/bin/env bash`, prefer lowercase function names, and keep helper scripts executable with `chmod +x`. Tmux and shell dotfiles retain leading dots; place overrides in repo before linking.

## Testing Guidelines
Syntax-check shell updates with `bash -n script.sh` or `zsh -n shell/.zshrc`. After editing tmux configs, start a session (`tmux new -d`) and run `tmux list-keys` to confirm bindings load. For Neovim, run `nvim --headless "+checkhealth" +qa` and open a buffer to ensure LSP or formatting changes behave locally. Keep manual smoke tests documented in commit messages when altering environment-critical files.

## Commit & Pull Request Guidelines
Recent history favors short, lowercase subjects (e.g., `add a rsync script`). Follow `imperative mood + context`, under ~70 characters. Group related edits per commit and mention affected tool (`nvim`, `tmux`, `shell`). Pull requests should describe motivation, highlight risky changes, and link any tracking issues. Include reproduction or verification steps (commands above) so reviewers can validate quickly.
