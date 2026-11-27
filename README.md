# CCXT plugins

Official [CCXT](https://github.com/ccxt/ccxt) plugins for AI assistants, in a small repository so that installing one downloads only these files, not the whole CCXT codebase.

The plugins are thin: manifests, a usage skill and icons. They contain no CCXT code.

- **`ccxt`** connects your assistant to the hosted CCXT MCP server at `https://docs.ccxt.com/mcp`: read-only public market data and interactive charts from major crypto exchanges. No install, no API key.
- **`ccxt-local`** runs the CCXT MCP server (`npx -y ccxt-mcp`) on your own computer: 100+ exchanges, balances, orders and opt-in trading, with your API keys kept on your machine.

Setup for every assistant: [docs.ccxt.com/docs/mcp](https://docs.ccxt.com/docs/mcp).

The source of truth is the [ccxt/ccxt](https://github.com/ccxt/ccxt) repository (`mcp/hosted/plugin`, `mcp/plugin`, `.claude/skills/ccxt-mcp`). Report problems at [ccxt/ccxt issues](https://github.com/ccxt/ccxt/issues).

## Claude

| Where | How |
|---|---|
| Claude web, desktop and Cowork (paid plans) | **Customize > Plugins > Add > Add marketplace**, enter `ccxt/ccxt-plugins`, add **CCXT**, then connect it on the plugin's **Connectors** tab |
| Claude Code | `claude plugin install ccxt --marketplace ccxt/ccxt-plugins` (hosted) or `claude plugin install ccxt-local --marketplace ccxt/ccxt-plugins` (local server) |
| Team and Enterprise | an Owner adds the marketplace under **Organization settings > Plugins & skills > Add > Sync from GitHub** |

Files: [`.claude-plugin/marketplace.json`](.claude-plugin/marketplace.json) and [`claude/`](claude/).

## License

MIT, as CCXT.
