#!/usr/bin/env bash
#
# install.sh — install the `headshot` Agent Skill into Claude Code and/or OpenAI Codex.
#
# Both tools implement the same open Agent Skills standard (https://agentskills.io),
# so the skill folder is byte-identical for both — only the discovery directory differs:
#   • Claude Code : ~/.claude/skills/headshot   (and <repo>/.claude/skills/headshot)
#   • OpenAI Codex: ~/.agents/skills/headshot   (and <repo>/.agents/skills/headshot)
#
# The canonical source of truth is ./headshot/ in this repo. This script COPIES it into
# each target (copy, not symlink: Claude's /skills does not list symlinked skills).
#
# Usage:
#   ./install.sh                 # install for both Claude and Codex (user-level, ~/)
#   ./install.sh --claude        # Claude only
#   ./install.sh --codex         # Codex only
#   ./install.sh --project DIR   # also install into DIR/.claude/skills and DIR/.agents/skills
#   ./install.sh --uninstall     # remove from the user-level locations

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$SCRIPT_DIR/headshot"
NAME="headshot"

DO_CLAUDE=1
DO_CODEX=1
PROJECT_DIR=""
UNINSTALL=0

while [ $# -gt 0 ]; do
  case "$1" in
    --claude)    DO_CLAUDE=1; DO_CODEX=0 ;;
    --codex)     DO_CLAUDE=0; DO_CODEX=1 ;;
    --project)   PROJECT_DIR="${2:-}"; shift ;;
    --uninstall) UNINSTALL=1 ;;
    -h|--help)   grep '^#' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
  shift
done

if [ ! -f "$SRC/SKILL.md" ]; then
  echo "error: canonical skill not found at $SRC/SKILL.md" >&2
  exit 1
fi

install_one() { # $1 = destination skills dir (…/.claude/skills or …/.agents/skills)
  local skills_dir="$1" dest="$1/$NAME"
  if [ "$UNINSTALL" = "1" ]; then
    rm -rf "$dest" && echo "  removed  $dest"
    return
  fi
  mkdir -p "$skills_dir"
  rm -rf "$dest"
  cp -R "$SRC" "$dest"
  echo "  installed $dest"
}

echo "headshot skill — source: $SRC"
[ "$DO_CLAUDE" = "1" ] && { echo "Claude Code:"; install_one "$HOME/.claude/skills"; }
[ "$DO_CODEX"  = "1" ] && { echo "OpenAI Codex:"; install_one "$HOME/.agents/skills"; }

if [ -n "$PROJECT_DIR" ]; then
  echo "Project ($PROJECT_DIR):"
  [ "$DO_CLAUDE" = "1" ] && install_one "$PROJECT_DIR/.claude/skills"
  [ "$DO_CODEX"  = "1" ] && install_one "$PROJECT_DIR/.agents/skills"
fi

if [ "$UNINSTALL" = "1" ]; then
  echo "Done (uninstalled)."
else
  echo ""
  echo "Done. Next steps:"
  [ "$DO_CLAUDE" = "1" ] && echo "  • Claude Code: discovers it automatically (run /skills to confirm)."
  [ "$DO_CODEX"  = "1" ] && echo "  • OpenAI Codex: restart Codex, then run /skills (or invoke with \$headshot)."
fi
