# Remote Server Dotfiles Setup

Quick setup for tmux and neovim on remote Linux servers. No shell config included.

## One-Line Install

```bash
curl -fsSL https://raw.githubusercontent.com/randomradio/dotfiles/main/install-remote.sh | bash
```

## What Gets Installed

- **Tmux**: Oh My Tmux with vim-style keybindings
- **Neovim**: LazyVim config
- **TPM**: Tmux Plugin Manager

## Post-Install

1. Start tmux: `tmux`
2. Install plugins: Press `Ctrl+g` then `I` (prefix + shift+i)

## Manual Setup (if script fails)

### Tmux Only
```bash
curl -fsSL https://github.com/randomradio/dotfiles/raw/main/tmux/.tmux.conf > ~/.tmux.conf
curl -fsSL https://github.com/randomradio/dotfiles/raw/main/tmux/.tmux.conf.local > ~/.tmux.conf.local
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Nvim Only
```bash
git clone --depth 1 --sparse https://github.com/randomradio/dotfiles.git ~/tmp-dotfiles
cd ~/tmp-dotfiles
git sparse-checkout set nvim
cp -r nvim ~/.config/
rm -rf ~/tmp-dotfiles
```

## Keybindings

| Action | Key |
|--------|-----|
| Prefix | `Ctrl+g` |
| Split horizontal | Prefix + `"` |
| Split vertical | Prefix + `%` |
| Navigate panes | Prefix + `hjkl` |
| New window | Prefix + `c` |
| Switch windows | Prefix + `0-9` |
