#!/bin/bash
# setup.sh — install the Gemini Notebook token-saver kit (macOS / Linux).
# Installs notebooklm-mcp-cli (nlm + MCP server), signs in once, and connects
# the MCP server to Claude Code and/or Codex if they are installed.
set -euo pipefail

say() { printf '\n\033[1m==> %s\033[0m\n' "$*"; }

if ! command -v uv >/dev/null 2>&1; then
  say "Installing uv (Python tool manager)"
  curl -LsSf https://astral.sh/uv/install.sh | sh
  export PATH="$HOME/.local/bin:$PATH"
fi

say "Installing notebooklm-mcp-cli"
uv tool install --upgrade notebooklm-mcp-cli
export PATH="$HOME/.local/bin:$PATH"

if nlm login --check >/dev/null 2>&1; then
  say "Google login already valid"
else
  say "Sign in to Google in the Chrome window that opens (one time only)"
  nlm login --storage file
fi
nlm login --check

if command -v claude >/dev/null 2>&1; then
  say "Connecting Claude Code"
  nlm setup add claude-code || true
fi
if command -v codex >/dev/null 2>&1; then
  say "Connecting Codex"
  nlm setup add codex || true
fi

HERE="$(cd "$(dirname "$0")/.." && pwd)"
install -m 755 "$HERE/scripts/nbq.sh" "$HOME/.local/bin/nbq"
[ -d "$HOME/.claude" ] && mkdir -p "$HOME/.claude/skills" && cp -R "$HERE/skills/gemini-notebook" "$HOME/.claude/skills/"
[ -d "$HOME/.codex" ]  && mkdir -p "$HOME/.codex/skills"  && cp -R "$HERE/skills/gemini-notebook" "$HOME/.codex/skills/"

say "Done. Try:  nbq \"<notebook title>\" \"your question\""
nlm doctor || true
