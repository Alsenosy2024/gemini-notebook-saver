# Paste this into Claude Code or Codex

Copy everything inside the box and send it to your agent:

```text
Install the Gemini Notebook (NotebookLM) token-saver kit from
https://github.com/Alsenosy2024/gemini-notebook-saver on this machine:

1. Clone the repo to a temp folder and read README.md.
2. Run: bash scripts/setup.sh
   - It installs `uv` if missing, then `notebooklm-mcp-cli` (gives the `nlm` CLI + MCP server).
   - It runs `nlm login`: a Chrome window opens. STOP and tell me to sign in to my Google
     account in that window. Wait until I confirm, then continue.
   - It registers the MCP server with whichever agents exist here (Claude Code and/or Codex).
3. Copy skills/gemini-notebook into my skills folder
   (Claude Code: ~/.claude/skills/ — Codex: ~/.codex/skills/) and scripts/nbq.sh into ~/.local/bin/.
4. Test: run `nlm login --check`, list my notebooks, then ask one notebook a short question
   with nbq.sh and show me only the answer.
5. Tell me in 3 lines what is now installed and how to use it.
Do not ask me for passwords or API keys. The only manual step is the Google sign-in window.
```

That's it. After setup just talk normally, for example:

- "Create a notebook called *Q3 Reports*, upload every PDF in ~/Downloads/reports, and tell me the 5 biggest risks."
- "Ask my *PMP* notebook what CPI means, then write a LinkedIn post from the answer."
- "Make an audio overview from notebook *Research* and download it."
