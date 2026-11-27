# CCXT for ChatGPT and Codex

| Where | How |
|---|---|
| ChatGPT desktop app and Codex CLI | `codex plugin marketplace add ccxt/ccxt-plugins`, then `codex plugin add ccxt@ccxt`. Restart the ChatGPT desktop app; CCXT appears in its Plugins Directory under the CCXT marketplace. |
| ChatGPT workspaces (admins) | **Admin > Plugins > Add > Import marketplace**, source `https://github.com/ccxt/ccxt-plugins` |
| ChatGPT web and mobile | not installable from here until the plugin is in OpenAI's directory: add the server URL `https://mcp.ccxt.com/mcp` as a custom MCP server ([steps](https://docs.ccxt.com/docs/mcp#chatgpt-web)) |

Files: [`../.agents/plugins/marketplace.json`](../.agents/plugins/marketplace.json) and [`ccxt/`](ccxt/).

For the OpenAI directory, upload a ZIP of the contents of `ccxt/` (with `plugin.json` and `mcp.json` at the root of the ZIP) at platform.openai.com/plugins.
