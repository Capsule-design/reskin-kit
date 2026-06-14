#!/usr/bin/env bash
# Reskin Kit one-line bootstrap.
# Clones the repo to a temp dir and runs install.sh — nothing left behind but ~/.claude.
#
# Usage (after you set REPO_URL below or via env):
#   curl -fsSL https://raw.githubusercontent.com/<you>/reskin-kit/main/bootstrap.sh | bash
# Or pin a repo without editing this file:
#   RESKIN_REPO=git@github.com:<you>/reskin-kit.git bash bootstrap.sh

set -euo pipefail

# 1) EDIT THIS once you've pushed the repo (or override with RESKIN_REPO env):
REPO_URL="${RESKIN_REPO:-https://github.com/Xactoblade/reskin-kit.git}"
BRANCH="${RESKIN_BRANCH:-main}"

if [[ "$REPO_URL" == *CHANGE-ME* ]]; then
  echo "✗ Set REPO_URL in bootstrap.sh (or pass RESKIN_REPO=...) to your repo first." >&2
  exit 1
fi

command -v git >/dev/null || { echo "✗ git is required." >&2; exit 1; }

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "Cloning $REPO_URL ($BRANCH) ..."
git clone --depth 1 --branch "$BRANCH" "$REPO_URL" "$TMP/reskin-kit"

cd "$TMP/reskin-kit"
chmod +x install.sh
./install.sh

echo "✓ Bootstrap complete."
