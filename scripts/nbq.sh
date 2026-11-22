#!/bin/bash
# nbq.sh — ask a Gemini Notebook (NotebookLM) and print ONLY the answer text.
# Drops citations/references (~10x smaller than raw MCP/JSON output) to save Claude tokens.
# usage: nbq.sh <notebook-id | "exact notebook title"> "question" [conversation-id]
set -euo pipefail
NB="$1"; Q="$2"; CONV="${3:-}"
if ! [[ "$NB" =~ ^[0-9a-f]{8}-[0-9a-f-]{27}$ ]]; then
  NB=$(nlm notebook list --json 2>/dev/null | python3 -c '
import sys, json
t = sys.argv[1]; d = json.load(sys.stdin)
d = d if isinstance(d, list) else d.get("notebooks", [])
m = [n.get("id") for n in d if (n.get("title") or "").strip() == t]
print(m[0] if m else "")' "$NB")
  [ -z "$NB" ] && { echo "notebook not found: $1" >&2; exit 2; }
fi
ARGS=(notebook query "$NB" "$Q" --json --timeout 180)
[ -n "$CONV" ] && ARGS+=(--conversation-id "$CONV")
nlm "${ARGS[@]}" 2>/dev/null | python3 -c '
import sys, json
d = json.load(sys.stdin)
print(d.get("answer", "").strip())
print("\n[conversation_id: %s]" % d.get("conversation_id", ""))'
