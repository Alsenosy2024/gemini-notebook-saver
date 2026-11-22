---
name: gemini-notebook
description: Offload heavy reading and analysis to Gemini Notebook (NotebookLM) and bring back only the answer — create notebooks, add sources (files, URLs, YouTube, Google Drive, text), ask the notebook, generate Studio outputs (audio overview, video, slides, mind map, report) and download them. Use when the user mentions NotebookLM / Gemini Notebook / نوت بوك, wants to analyze big documents, or wants to save tokens.
---

# Gemini Notebook — the agent directs, the notebook reads

**Golden rule:** big files never enter your context. Push them into a notebook, ask the
notebook, and keep only its short answer. That is where the token saving comes from.

## Tools
`notebooklm-mcp-cli` gives you both an MCP server (`notebook_*`, `source_*`, `studio_*`,
`download_*` tools) and the `nlm` CLI. Run `nlm --ai` for the full reference.

## Workflow
1. **Notebook:** reuse one (`nlm notebook list`) or create one (`nlm notebook create "Title"`).
2. **Sources:** `nlm source add <notebook> --file ./report.pdf` (also `--url`, `--youtube`,
   `--text`, `--drive`). Wait until each source is ready before asking.
3. **Ask (answer only):** `nbq "<notebook title or id>" "question"`
   - Prints just the answer plus a `conversation_id`; pass it as a 3rd argument for follow-ups.
   - Prefer `nbq` over the raw `notebook_query` tool: raw output carries ~10x more text
     (citations and quoted passages) that you do not need.
4. **Studio (optional):** `nlm audio create <notebook> --confirm`, `nlm studio create ...`,
   then `nlm download all <notebook> -d ./out`.
5. Continue the user's task (post, report, email…) using only the answer.

## Ask well
- One precise question per call; ask for the format you need ("5 bullets", "a table").
- Ask the notebook to cite; check numbers before publishing.
- Several notebooks: `nlm cross query` instead of looping.

## Maintenance
- `nlm login --check` — if stale, run `nlm login` (Chrome opens; the user signs in once).
- `uv tool upgrade notebooklm-mcp-cli` if Google changes the web app and something breaks.
- `nlm usage` shows remaining NotebookLM quota.
- Official Google MCP (create notebooks / add sources only) is documented in `docs/official-mcp.md`.
