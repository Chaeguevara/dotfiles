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

## Guides

Basic → advanced cheatsheets, with command sets for real scenarios:

- **[docs/nvim.md](docs/nvim.md)** — Neovim / LazyVim: the verb+motion grammar, LSP,
  treesitter selection, and scenarios (rename a symbol, refactor a function,
  project-wide replace, lazygit, multi-cursor-style edits, macros, `:g`, registers).
- **[docs/tmux.md](docs/tmux.md)** — tmux: sessions/windows/panes, copy mode, and
  scenarios (dev session layout, detach/attach, keep jobs alive over SSH, sync panes,
  scripted workspaces).

## Set up a new machine

```bash
# 1. Clone
git clone https://github.com/Chaeguevara/dotfiles ~/dotfiles

# 2. Install every CLI tool + font from the Brewfile
brew bundle --file ~/dotfiles/Brewfile

# 3. Symlink configs into $HOME (also clones tpm)
cd ~/dotfiles && ./install.sh

# 4. Restart the shell, then open nvim once to let plugins install
exec zsh
nvim                      # LazyVim bootstraps all plugins on first launch
# in tmux, press: prefix + I   → installs tmux-resurrect / continuum
```

Set your terminal font to **JetBrainsMono Nerd Font** so icons render.

The **`Brewfile`** captures every installed tool, so `brew bundle` reproduces the whole
toolchain on a new machine. Refresh it after installing new tools:
`brew bundle dump --file ~/dotfiles/Brewfile --force`.

## Secrets

Machine-local secrets (API keys, tokens) go in `~/.zshrc.local`, which is
gitignored and sourced automatically by `.zshrc`. Nothing secret is committed.

## How sync works

The real files in `$HOME` are **symlinks** into this repo, so editing e.g.
`~/.zshrc` edits the repo copy directly. Commit and push to sync; pull on
another machine to receive.
