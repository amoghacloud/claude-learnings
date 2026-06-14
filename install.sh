#!/bin/bash
set -e

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_SKILLS_DIR="$HOME/.claude/skills"
LEARNINGS_DIR="$HOME/.claude-learnings"

echo "Installing Claude Learnings skill..."

# 1. Create local learnings storage
mkdir -p "$LEARNINGS_DIR/by-project"
mkdir -p "$LEARNINGS_DIR/by-domain"

# 2. Create index.md if it doesn't exist
if [ ! -f "$LEARNINGS_DIR/index.md" ]; then
cat > "$LEARNINGS_DIR/index.md" << 'EOF'
# Claude Learnings Index

## Projects
<!-- auto-updated by /learnings capture and /learnings close -->

## Domains
<!-- auto-updated by /learnings capture and /learnings close -->
EOF
echo "Created $LEARNINGS_DIR/index.md"
fi

# 3. Install skill into Claude Code skills directory
mkdir -p "$CLAUDE_SKILLS_DIR"
SKILL_DEST="$CLAUDE_SKILLS_DIR/learnings"

if [ -L "$SKILL_DEST" ]; then
  rm "$SKILL_DEST"
fi

ln -s "$SKILL_DIR/skill" "$SKILL_DEST"
echo "Linked skill → $SKILL_DEST"

echo ""
echo "✓ Claude Learnings installed."
echo ""
echo "Usage in any Claude Code project:"
echo "  /learnings load     ← start of session"
echo "  /learnings capture  ← after any correction"
echo "  /learnings close    ← end of project"
echo ""
echo "Learnings stored at: $LEARNINGS_DIR"
