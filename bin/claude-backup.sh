#!/usr/bin/env bash
# Snapshot curated Claude Code config into this dotfiles repo, then commit + push.
#
# ALLOWLIST ONLY. This never sweeps ~/.claude wholesale, because that dir also
# holds secrets and transient data we must not publish (this repo is public):
#   - ~/.claude.json          OAuth / API credentials   (lives in $HOME, not swept)
#   - ~/.claude/projects/     session transcripts + memory (may contain secrets)
#   - sessions/ history.jsonl shell-snapshots/ cache/ telemetry/  (transient/huge)
#   - settings.local.json     machine-local
# We copy only the portable, non-secret config listed below.
set -euo pipefail

DOT="$HOME/dotfiles"
SRC="$HOME/.claude"
DST="$DOT/.claude"
mkdir -p "$DST"

# --- curated allowlist ------------------------------------------------------
FILES=(CLAUDE.md RTK.md keybindings.json settings.json)   # single files
DIRS=(hooks commands agents)                              # whole dirs (minus *.bak)

for f in "${FILES[@]}"; do
  [ -f "$SRC/$f" ] && cp "$SRC/$f" "$DST/$f"
done
for d in "${DIRS[@]}"; do
  [ -d "$SRC/$d" ] && rsync -a --delete \
      --exclude='*.bak' --exclude='*.bak.*' "$SRC/$d/" "$DST/$d/"
done

# Record installed skills/plugins by name so install.sh can reinstall them.
# (The skill *contents* are third-party — reinstall, don't vendor.)
ls "$SRC/skills"  2>/dev/null | sort > "$DST/skills.list"  || true
ls "$SRC/plugins/cache" 2>/dev/null | sort > "$DST/plugins.list" || true

# --- secret tripwire: refuse to commit obvious secrets ----------------------
if grep -rInE 'sk-ant-|BEGIN [A-Z ]*PRIVATE KEY|"?(api[_-]?key|secret|token|password)"?\s*[:=]\s*["'\''][A-Za-z0-9/_-]{16,}' "$DST" 2>/dev/null; then
  echo "ABORT: possible secret in staged Claude config above — not committing." >&2
  exit 1
fi

# --- commit + push ----------------------------------------------------------
cd "$DOT"
git add .claude
if git diff --cached --quiet; then
  echo "Claude config already up to date — nothing to sync."
  exit 0
fi
git commit -qm "chore(claude): sync config $(date +%F)"
git push -q && echo "Synced ~/.claude config to dotfiles and pushed."
