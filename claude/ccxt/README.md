# CCXT — hosted market-data plugin

This plugin connects your assistant to the **hosted CCXT MCP server** at `https://mcp.ccxt.com/mcp` and adds a skill that teaches the assistant how to use it, plus skills for writing code with the CCXT library. Nothing runs on your computer, and no exchange account or API key is needed.

Ask for prices, order books, OHLCV candles, recent trades and market listings on a curated set of major cryptocurrency exchanges. In hosts that render [MCP Apps](https://modelcontextprotocol.io/docs/extensions/apps), the assistant can also show an interactive candlestick chart, an order-book depth view or a price board in the chat.

The server is **read-only and public**. It does not place orders, move funds or read exchange accounts. For balances, orders, positions and opt-in trading, use the local CCXT MCP server (`ccxt-mcp` on npm), which keeps your API keys on your own machine: see the [CCXT MCP docs](https://docs.ccxt.com/docs/mcp).

## Install

- **Claude (web, desktop, Cowork; paid plans):** **Customize > Plugins > Add > Add marketplace**, enter `ccxt/ccxt-plugins`, add **CCXT**, then connect its server on the plugin's **Connectors** tab. It is then also available in the Claude mobile apps. On the Free plan, add `https://mcp.ccxt.com/mcp` as a custom connector instead (Customize > Connectors > Add custom connector).
- **Claude Code:**

  ```bash
  claude plugin install ccxt --marketplace ccxt/ccxt-plugins
  ```

  Older versions: `/plugin marketplace add ccxt/ccxt-plugins`, then `/plugin install ccxt@ccxt`. Or add the server alone, without the skill: `claude mcp add --transport http ccxt https://mcp.ccxt.com/mcp`.
- **ChatGPT, Codex and other hosts:** see [Hosted server (no install)](https://docs.ccxt.com/docs/mcp#hosted-server-no-install) in the docs.

### Skip the approval prompts

Every tool here is read-only, but Claude decides when to ask, from your settings:

- **Claude (web, desktop, mobile):** Customize > Connectors > CCXT > **Tool permissions** > **Always allow**.
- **Claude Code:** add `"mcp__plugin_ccxt_ccxt__*"` to `permissions.allow` in `~/.claude/settings.json`, or run `/permissions`. A plugin cannot pre-approve its own tools.

## What is in this folder

| File | Purpose |
|---|---|
| `.claude-plugin/plugin.json` | the plugin manifest |
| `.mcp.json` | the hosted server (`"type": "http"`, `https://mcp.ccxt.com/mcp`) |
| `skills/ccxt/SKILL.md` | how the assistant uses the tools |
| `skills/ccxt-<language>/SKILL.md` | how to write code with the CCXT library: `ccxt-typescript`, `ccxt-python`, `ccxt-php`, `ccxt-csharp`, `ccxt-go`, `ccxt-java`, `ccxt-rust`, `ccxt-cli` |
| `assets/` | icon and logo for directory listings |

The skills are copied from ccxt/ccxt by the sync (see the [top-level README](../../README.md#keeping-in-sync-with-ccxtccxt)); edit them there. This folder's manifest and README are maintained here; they started from [`mcp/hosted/plugin`](https://github.com/ccxt/ccxt/tree/master/mcp/hosted/plugin) in ccxt/ccxt, which is not copied over.

## Privacy

The server receives the tool calls your assistant makes: the tool name and arguments such as exchange ids, symbols and timeframes. It does not receive your conversation, and it accepts no credentials. It records anonymous usage analytics and request logs, without IP addresses and without the data it returns. With analytics on, each tool call can also carry a one-line reason written by the assistant, which may paraphrase your request. [Privacy](https://docs.ccxt.com/docs/mcp#privacy) in the docs describes what is recorded.

## Support

https://github.com/ccxt/ccxt/issues

## License

MIT. See `LICENSE`.
