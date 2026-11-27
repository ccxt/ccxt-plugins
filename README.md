# CCXT plugins

Official [CCXT](https://github.com/ccxt/ccxt) plugins for AI assistants, in a small repository so that installing one downloads only these files, not the whole CCXT codebase.

The plugins are thin: manifests, skills and icons. They contain no CCXT code.

- **`ccxt`** connects your assistant to the hosted CCXT MCP server at `https://docs.ccxt.com/mcp`: read-only public market data and interactive charts from major crypto exchanges, no API key. It also carries the skills for writing code with the CCXT library (TypeScript, Python, PHP, C#, Go, Java, Rust and the CLI), for assistants that can run code with access to the exchanges, such as Claude Code, Codex or a cloud environment you allowed to reach them.
- **`ccxt-local`** runs the CCXT MCP server (`npx -y ccxt-mcp`) on your own computer: 100+ exchanges, balances, orders and opt-in trading, with your API keys kept on your machine.

Setup for every assistant: [docs.ccxt.com/docs/mcp](https://docs.ccxt.com/docs/mcp).

The source of truth is the [ccxt/ccxt](https://github.com/ccxt/ccxt) repository (`mcp/hosted/plugin`, `mcp/plugin`, `.claude/skills`); this repository holds published copies. Report problems at [ccxt/ccxt issues](https://github.com/ccxt/ccxt/issues).

## Keeping in sync with ccxt/ccxt

Every skill here is a copy from ccxt/ccxt `master`. [`sync-from-ccxt.yml`](.github/workflows/sync-from-ccxt.yml) copies them every six hours (or when run by hand from the Actions tab) with [`scripts/sync-from-ccxt.sh`](scripts/sync-from-ccxt.sh), raises the patch version of each plugin that changed, and commits to `main`. Edit skills in ccxt/ccxt, not here: the next sync would overwrite a change made here. Manifests and READMEs are written here; when you change a manifest by hand, raise its `version` too, since Claude Code only updates an installed plugin when its version changes.

Claude Code does not auto-update plugins from this marketplace by default. Run `claude plugin update ccxt@ccxt`, or turn on auto-update for the `ccxt` marketplace under `/plugin` > **Marketplaces**.

## Claude

| Where | How |
|---|---|
| Claude web, desktop and Cowork (paid plans) | **Customize > Plugins > Add > Add marketplace**, enter `ccxt/ccxt-plugins`, add **CCXT**, then connect it on the plugin's **Connectors** tab |
| Claude Code | `claude plugin install ccxt --marketplace ccxt/ccxt-plugins` (hosted) or `claude plugin install ccxt-local --marketplace ccxt/ccxt-plugins` (local server) |
| Team and Enterprise | an Owner adds the marketplace under **Organization settings > Plugins & skills > Add > Sync from GitHub** |

Files: [`.claude-plugin/marketplace.json`](.claude-plugin/marketplace.json) and [`claude/`](claude/).

## ChatGPT and Codex

| Where | How |
|---|---|
| ChatGPT desktop app, Codex CLI and IDE extension | `codex plugin marketplace add ccxt/ccxt-plugins`, then `codex plugin add ccxt@ccxt`; restart the ChatGPT desktop app |
| ChatGPT workspaces | an admin imports `https://github.com/ccxt/ccxt-plugins` under **Admin > Plugins > Add > Import marketplace** |
| ChatGPT web and mobile | add `https://docs.ccxt.com/mcp` as a custom MCP server ([steps](https://docs.ccxt.com/docs/mcp#chatgpt-web)) |

Files: [`.agents/plugins/marketplace.json`](.agents/plugins/marketplace.json) and [`chatgpt/`](chatgpt/).

## License

MIT, as CCXT.
