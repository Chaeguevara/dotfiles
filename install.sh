#!/usr/bin/env bash
# Symlink dotfiles from this repo into $HOME.
# Idempotent: existing real files are backed up to *.bak before linking.
set -euo pipefail

DOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
  local src="$DOT/$1" dst="$HOME/$1"
  mkdir -p "$(dirname "$dst")"
  # If a real (non-symlink) file is in the way, back it up.
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mv "$dst" "$dst.bak"
    echo "backed up existing $dst -> $dst.bak"
  fi
  ln -sfn "$src" "$dst"
  echo "linked $dst -> $src"
}

link .zshrc
link .tmux.conf
link .gitconfig
link .config/starship.toml
link .config/nvim

# tmux plugin manager (needed by .tmux.conf plugins)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  echo "cloned tpm — open tmux and press 'prefix + I' to install plugins"
fi

echo
echo "Done. Restart your shell (or: source ~/.zshrc)."
echo "Put any secrets in ~/.zshrc.local (gitignored)."
echo "Brew packages: run 'brew bundle --file ~/dotfiles/Brewfile' to install them all."
