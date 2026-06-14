#!/usr/bin/env bash
# Reskin Kit installer — installs the reskin skill + all commands into ~/.claude
# Portable across machines (MacBook, Forge/Mac Studio, etc.). Idempotent.
#
#   ./install.sh              install / update
#   ./install.sh --uninstall  remove
#   CLAUDE_DIR=/path ./install.sh   install to a custom Claude dir

set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${CLAUDE_DIR:-$HOME/.claude}"
SKILL_DST="$CLAUDE_DIR/skills/reskin"

uninstall() {
  rm -rf "$SKILL_DST"
  for f in "$SRC_DIR"/commands/*.md; do
    rm -f "$CLAUDE_DIR/commands/$(basename "$f")"
  done
  echo "✓ Removed reskin skill and commands from $CLAUDE_DIR"
  exit 0
}

[ "${1:-}" = "--uninstall" ] && uninstall

echo "Installing Reskin Kit → $CLAUDE_DIR"
mkdir -p "$CLAUDE_DIR/skills" "$CLAUDE_DIR/commands"

# Skill (folder)
rm -rf "$SKILL_DST"
cp -R "$SRC_DIR/skills/reskin" "$SKILL_DST"
echo "✓ Skill installed:   $SKILL_DST"

# All slash commands in commands/
for f in "$SRC_DIR"/commands/*.md; do
  cp "$f" "$CLAUDE_DIR/commands/$(basename "$f")"
  echo "✓ Command installed: $CLAUDE_DIR/commands/$(basename "$f")"
done

echo
echo "Done. In any Claude Code session you can now run:"
echo "    /reskin https://thesite.com page      # restyle to match (look + motion)"
echo "    /capture-design https://thesite.com   # save a reference spec, change nothing"
echo
echo "Tip: live-URL motion capture needs the Chrome MCP connected."
