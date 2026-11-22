# Gemini Notebook Saver

**Let Gemini Notebook (NotebookLM) do the heavy reading. Your AI agent only gets the answer.**
Works with **Claude Code** and **Codex (ChatGPT)**.

<div dir="rtl">

### بالعربي في 4 سطور
- بدل ما Claude أو ChatGPT يقرا ملفاتك الكبيرة ويصرف رصيدك، الملفات بتترفع على Gemini Notebook وهو اللي يقراها ويحللها على اشتراك جوجل.
- الـ Agent بيسأل سؤال قصير وياخد الإجابة بس — توفير كبير جداً في التوكنز.
- التثبيت: انسخ البرومبت اللي في [INSTALL_PROMPT.md](INSTALL_PROMPT.md) وابعته لـ Claude Code أو Codex، وهو يعمل كل حاجة.
- الخطوة اليدوية الوحيدة: تسجيل دخول جوجل مرة واحدة في نافذة Chrome.

</div>

## Why it saves tokens
| | Agent reads the files itself | With this kit |
|---|---|---|
| A 300-page PDF | the whole PDF goes into the agent's context | the PDF goes to NotebookLM |
| A question | big context on every turn | one short question |
| What the agent receives | everything | only the answer (~1 KB) |

Real test: asking a PMP study notebook "top 5 exam tips" → NotebookLM answered in 27 s;
the raw response was ~12 KB, the answer the agent keeps was 1.2 KB.

## Install (1 minute + one Google sign-in)
Paste the prompt from **[INSTALL_PROMPT.md](INSTALL_PROMPT.md)** into Claude Code or Codex.
Or run it yourself:
```bash
git clone https://github.com/Alsenosy2024/gemini-notebook-saver
cd gemini-notebook-saver && bash scripts/setup.sh
```

## Use
Just talk to your agent:
- "Upload these PDFs to a new notebook and give me the 5 key risks."
- "Ask my *Research* notebook for every statistic about X, then draft a report."
- "Create an audio overview of notebook *Course* and download it."

Or from the terminal: `nbq "<notebook title>" "your question"`.

## What's inside
| Path | What it is |
|---|---|
| `INSTALL_PROMPT.md` | copy-paste prompt for Claude Code / Codex |
| `scripts/setup.sh` | installs everything, signs in, connects your agents |
| `scripts/nbq.sh` | asks a notebook and prints **only** the answer |
| `skills/gemini-notebook/SKILL.md` | teaches the agent the "notebook reads, agent directs" workflow |
| `docs/official-mcp.md` | optional: Google's official MCP server (OAuth) |

## Official + unofficial, best of both
- **Engine:** [notebooklm-mcp-cli](https://github.com/jacob-bd/notebooklm-mcp-cli) (MIT, by jacob-bd) —
  full control: ask notebooks, Studio (audio, video, slides, mind map, reports), file and Drive upload, downloads.
  It uses your Google login cookies, so it can break when Google changes the site; `uv tool upgrade notebooklm-mcp-cli` fixes most cases.
- **Fallback:** Google's official [Gemini Notebook MCP](https://developers.google.com/notebook/docs/mcp) —
  stable OAuth, but only creates notebooks and adds sources. Setup in `docs/official-mcp.md`.

## Notes
- Your Google login stays on your machine (`~/.notebooklm-mcp-cli/`). Never share that folder.
- NotebookLM plan limits apply; check with `nlm usage`.

License: MIT · By Dr. Ahmed Al-Senosy
