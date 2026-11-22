# Optional: Google's official Gemini Notebook MCP

Google publishes an official remote MCP server at `https://notebook.googleapis.com/mcp`
(Public Preview). It is stable and uses OAuth, but today it only exposes 7 tools:
create/list/get/update notebooks and add/list/get sources (web URL, YouTube, text, Markdown).
It **cannot** ask a notebook or create Studio outputs — that is why this kit uses
`notebooklm-mcp-cli` as the main engine and the official server as a fallback for feeding sources.

Docs: https://developers.google.com/notebook/docs/mcp

## Setup with Claude Code (about 5 minutes)
1. Install the gcloud CLI and create a project:
   `gcloud projects create my-notebook-mcp && gcloud services enable notebook.googleapis.com --project my-notebook-mcp`
2. Google Cloud Console → Google Auth Platform:
   - Branding: app name + your email. Audience: External, then **add yourself as a Test user**.
   - Clients → Create → **Web application**, redirect URIs:
     `http://localhost:8765/callback` (Claude Code) and `https://claude.ai/api/mcp/auth_callback` (claude.ai connector).
3. Add the server (the secret is read from an env var, never typed on the command line history):
   ```bash
   read -s MCP_CLIENT_SECRET && export MCP_CLIENT_SECRET
   claude mcp add --transport http --scope user \
     --client-id <CLIENT_ID> --client-secret --callback-port 8765 \
     gemini-notebook https://notebook.googleapis.com/mcp
   claude mcp login gemini-notebook
   ```
4. Test: ask your agent "list my notebooks".

Notes
- While the app is in *Testing*, Google expires the login after ~7 days: run `claude mcp login gemini-notebook` again.
- `gcloud auth application-default login` with the notebook scope is blocked by Google — use your own OAuth client as above.
- Uploading local files is a separate REST call (`UploadSource`), not an MCP tool.
