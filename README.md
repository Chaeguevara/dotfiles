# dotfiles

My terminal + Neovim setup, synced across machines.

## What's here

| Path | What |
|------|------|
| `.zshrc` | zsh config (aliases, `nvim` as default editor, starship, nvm) |
| `.tmux.conf` | tmux: mouse, true-color, vim-aware pane navigation |
| `.gitconfig` | git identity + defaults |
| `.config/starship.toml` | starship prompt theme |
| `.config/nvim/` | Neovim config (LazyVim + JS/TS LSP, Prettier, ESLint, outline) |

## Set up a new machine

```bash
# 1. Prerequisites (macOS)
brew install neovim tmux fd ripgrep lazygit node starship
brew install --cask font-jetbrains-mono-nerd-font

# 2. Clone and link
git clone https://github.com/<you>/dotfiles ~/dotfiles
cd ~/dotfiles && ./install.sh

# 3. Restart the shell, then open nvim once to let plugins install
exec zsh
nvim   # LazyVim bootstraps all plugins on first launch
```

Set your terminal font to **JetBrainsMono Nerd Font** so icons render.

## Secrets

Machine-local secrets (API keys, tokens) go in `~/.zshrc.local`, which is
gitignored and sourced automatically by `.zshrc`. Nothing secret is committed.

## How sync works

The real files in `$HOME` are **symlinks** into this repo, so editing e.g.
`~/.zshrc` edits the repo copy directly. Commit and push to sync; pull on
another machine to receive.
