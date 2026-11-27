# CCXT — hosted market-data plugin for ChatGPT and Codex

This plugin connects ChatGPT or Codex to the **hosted CCXT MCP server** at `https://docs.ccxt.com/mcp` and adds a skill that teaches the assistant how to use it. Nothing runs on your computer, and no exchange account or API key is needed.

Ask for prices, order books, OHLCV candles, recent trades and market listings on a curated set of major cryptocurrency exchanges. ChatGPT can also show an interactive candlestick chart, an order-book depth view or a price board in the chat.

The server is **read-only and public**. It does not place orders, move funds or read exchange accounts. For balances, orders, positions and opt-in trading, use the local CCXT MCP server (`ccxt-mcp` on npm), which keeps your API keys on your own machine: see the [CCXT MCP docs](https://docs.ccxt.com/docs/mcp).

Install: see [../README.md](../README.md).

## What is in this folder

| File | Purpose |
|---|---|
| `plugin.json` | the plugin manifest (Agent Plugins format) with the OpenAI listing, review test cases and icons under `extensions["com.openai"]` |
| `mcp.json` | the hosted server (`"type": "streamable-http"`, `https://docs.ccxt.com/mcp`) |
| `skills/ccxt/SKILL.md` | how the assistant uses the tools |
| `assets/` | logo and composer icons |

The source is [`mcp/hosted/plugin`](https://github.com/ccxt/ccxt/tree/master/mcp/hosted/plugin) in ccxt/ccxt, where CI checks the manifests.

## Support

[ccxt/ccxt issues](https://github.com/ccxt/ccxt/issues).
