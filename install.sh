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

# tmux plugin manager + plugins (needed by .tmux.conf)
mkdir -p "$HOME/.tmux/plugins"
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  echo "cloned tpm"
fi
[ ! -d "$HOME/.tmux/plugins/tmux-resurrect" ] && \
  git clone https://github.com/tmux-plugins/tmux-resurrect "$HOME/.tmux/plugins/tmux-resurrect" 2>/dev/null || true
[ ! -d "$HOME/.tmux/plugins/tmux-continuum" ] && \
  git clone https://github.com/tmux-plugins/tmux-continuum "$HOME/.tmux/plugins/tmux-continuum" 2>/dev/null || true

# --- Oh My Zsh custom plugins -----------------------------------------------
# Ensure custom plugins used by .zshrc are installed so fresh setups don't complain
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ -d "$HOME/.oh-my-zsh" ]; then
  mkdir -p "$ZSH_CUSTOM/plugins"
  [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && \
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" 2>/dev/null || true
  [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" 2>/dev/null || true
  [ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ] && \
    git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions" 2>/dev/null || true
fi

# --- Machine-local config template ------------------------------------------
if [ ! -f "$HOME/.zshrc.local" ] && [ -f "$DOT/.zshrc.local.example" ]; then
  cp "$DOT/.zshrc.local.example" "$HOME/.zshrc.local"
  echo "created ~/.zshrc.local from template"
fi

# --- Claude Code config -----------------------------------------------------
# Copied, not symlinked: Claude rewrites these live, and only a curated
# allowlist is in the repo (see bin/claude-backup.sh). Secrets are never here.
if [ -d "$DOT/.claude" ]; then
  mkdir -p "$HOME/.claude"
  for f in CLAUDE.md RTK.md keybindings.json settings.json; do
    [ -f "$DOT/.claude/$f" ] && cp "$DOT/.claude/$f" "$HOME/.claude/$f"
  done
  for d in hooks commands agents; do
    [ -d "$DOT/.claude/$d" ] && { mkdir -p "$HOME/.claude/$d"; cp -R "$DOT/.claude/$d/." "$HOME/.claude/$d/"; }
  done
  echo "restored curated ~/.claude config"
fi

# Reinstall the third-party Claude skills (idempotent). See .claude/skills.list.
if command -v npx >/dev/null 2>&1; then
  npx -y skills add JuliusBrussee/caveman -g -y || true
  npx -y skills add mattpocock/skills --skill handoff -g -y || true
  npx -y skills add mattpocock/skills --skill edit-article -g -y || true
  npx -y skills add https://github.com/crafter-station/skills/tree/main/context-engineering/intent-layer --skill intent-layer -g -y || true
  npx -y skills add vercel-labs/skills --skill find-skills -g -y || true
  npx -y skills add autodesk-platform-services/skills -g -y || true
fi

# RTK (headroom) token-saving proxy: install headroom's `rtk` binary, ensure it
# is on PATH, then re-patch the hook so its integrity check passes.
# ponytail: headroom's installer URL isn't scripted here — add it once you know it.
if command -v rtk >/dev/null 2>&1; then
  rtk init -g --auto-patch || true
else
  echo "NOTE: install headroom (provides ~/.headroom/bin/rtk), add it to PATH in"
  echo "      ~/.zshrc.local, then run 'rtk init -g --auto-patch' for token savings."
fi

echo
echo "Done. Restart your shell (or: source ~/.zshrc)."
echo "Put any secrets in ~/.zshrc.local (gitignored)."
echo "Brew packages: run 'brew bundle --file ~/dotfiles/Brewfile' to install them all."
