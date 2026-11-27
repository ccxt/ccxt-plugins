<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset=".github/assets/header-dark.svg">
    <img alt="CCXT: crypto markets in your AI assistant" src=".github/assets/header-light.svg" width="100%">
  </picture>
</p>

<p align="center">
  Ask your assistant for prices, order books and charts from major crypto exchanges, and get them back as live, interactive views in the chat.<br>
  No install, no sign-in and no API keys: it connects to the hosted CCXT server at <code>https://docs.ccxt.com/mcp</code>.
</p>

<p align="center">
  <a href="https://claude.ai/customize/connectors?modal=add-custom-connector&connectorName=CCXT&connectorUrl=https%3A%2F%2Fdocs.ccxt.com%2Fmcp"><picture><source media="(prefers-color-scheme: dark)" srcset=".github/assets/btn-claude-dark.svg"><img alt="Add to Claude" src=".github/assets/btn-claude-light.svg" height="48"></picture></a>
  <a href="https://chatgpt.com/plugins"><picture><source media="(prefers-color-scheme: dark)" srcset=".github/assets/btn-chatgpt-dark.svg"><img alt="Add to ChatGPT" src=".github/assets/btn-chatgpt-light.svg" height="48"></picture></a>
  <a href="https://cursor.com/install-mcp?name=CCXT&config=eyJ1cmwiOiJodHRwczovL2RvY3MuY2N4dC5jb20vbWNwIn0%3D"><picture><source media="(prefers-color-scheme: dark)" srcset=".github/assets/btn-cursor-dark.svg"><img alt="Add to Cursor" src=".github/assets/btn-cursor-light.svg" height="48"></picture></a>
  <a href="https://vscode.dev/redirect?url=vscode%3Amcp%2Finstall%3F%257B%2522name%2522%253A%2522CCXT%2522%252C%2522type%2522%253A%2522http%2522%252C%2522url%2522%253A%2522https%253A%252F%252Fdocs.ccxt.com%252Fmcp%2522%257D"><picture><source media="(prefers-color-scheme: dark)" srcset=".github/assets/btn-vscode-dark.svg"><img alt="Add to VS Code" src=".github/assets/btn-vscode-light.svg" height="48"></picture></a>
</p>

<p align="center"><sub><b>ChatGPT:</b> the button opens Plugins. Select <b>+</b> › <b>Add custom MCP server</b>, paste <code>https://docs.ccxt.com/mcp</code> and choose <b>No authentication</b>.</sub></p>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset=".github/assets/demo-dark.gif">
    <img alt="The CCXT views in a chat: a BTC/USDT candlestick chart, an order book with depth chart, and a price board, filled with real data from the hosted server" src=".github/assets/demo-light.gif" width="720">
  </picture>
  <br><sub>Real, live data from <code>docs.ccxt.com/mcp</code>, recorded in the views the plugin ships.</sub>
</p>

## Install

**Claude Code**: the plugin adds the server and the CCXT skills in one step.

```bash
claude plugin install ccxt --marketplace ccxt/ccxt-plugins
```

**Codex and the ChatGPT desktop app**: add the marketplace, then the plugin, then restart the ChatGPT app.

```bash
codex plugin marketplace add ccxt/ccxt-plugins
codex plugin add ccxt@ccxt
```

**Claude web and desktop**: the **Add to Claude** button above adds the server as a connector, on every plan. On a paid plan you can install the plugin instead, which also brings the skills: **Customize > Plugins > Add > Add marketplace**, enter `ccxt/ccxt-plugins`, add **CCXT**, then connect it on the plugin's **Connectors** tab.

**ChatGPT web and mobile**: open [Plugins](https://chatgpt.com/plugins), select **+** then **Add custom MCP server**, paste `https://docs.ccxt.com/mcp` and choose **No authentication** ([step by step](https://docs.ccxt.com/docs/mcp#chatgpt-web)).

**Anything else**: any MCP host that can add a remote server works. Use `https://docs.ccxt.com/mcp`, over Streamable HTTP, with no auth.

<details>
<summary><b>Other ways and older versions</b></summary>

- **Claude Code older than 2.1.292** has no `--marketplace`. Run `claude plugin marketplace add ccxt/ccxt-plugins`, then `claude plugin install ccxt@ccxt`. Inside a session: `/plugin marketplace add ccxt/ccxt-plugins`, then `/plugin install ccxt@ccxt`.
- **Server only, without the skills:** `claude mcp add --transport http ccxt https://docs.ccxt.com/mcp`, or in `~/.codex/config.toml`:

  ```toml
  [mcp_servers.ccxt]
  url = "https://docs.ccxt.com/mcp"
  ```

- **Gemini CLI:** `gemini mcp add --transport http ccxt https://docs.ccxt.com/mcp`
- **Cursor or VS Code by hand:** `{ "mcpServers": { "ccxt": { "url": "https://docs.ccxt.com/mcp" } } }` in `~/.cursor/mcp.json`, or `{ "servers": { "ccxt": { "type": "http", "url": "https://docs.ccxt.com/mcp" } } }` in `.vscode/mcp.json`.
- **Teams:** on Claude Team and Enterprise, an Owner adds the marketplace for everyone under **Organization settings > Plugins & skills > Add > Sync from GitHub**. On a ChatGPT workspace, an admin imports `https://github.com/ccxt/ccxt-plugins` under **Admin > Plugins > Add > Import marketplace**.
- **Stop the approval prompts:** every tool on the hosted server is read-only. In Claude, open **Customize > Connectors > CCXT** and set **Tool permissions** to **Always allow**. In Claude Code, add `"mcp__plugin_ccxt_ccxt__*"` to `permissions.allow`.

</details>

## Just ask

> *What's BTC trading at on Binance, Coinbase and Kraken?*
>
> *Show me a 4h chart of ETH/USDT for the last two weeks.*
>
> *How deep is the SOL/USDT order book? Where's the spread?*
>
> *Compare BTC, ETH and SOL: last price, 24h change and volume.*
>
> *Write a Python script that saves hourly BTC/USDT candles to CSV.*

The chart, order book and price board open as interactive views in Claude and ChatGPT, and update live while they're on screen. Other hosts get the same data as text.

## Trade from your assistant

The hosted server only reads public market data. For your balances, orders and positions, and opt-in trading on 100+ exchanges, run the CCXT server on your own computer. Your API keys stay on your machine and the model never sees them. Trading stays off until you enable it per account, and every order is previewed and confirmed first.

<p>
  <a href="https://github.com/ccxt/ccxt/releases/download/ccxt-mcp-latest/ccxt-mcp.mcpb"><picture><source media="(prefers-color-scheme: dark)" srcset=".github/assets/btn-desktop-dark.svg"><img alt="Claude Desktop: one-click local server" src=".github/assets/btn-desktop-light.svg" height="48"></picture></a>
</p>

```bash
claude plugin install ccxt-local --marketplace ccxt/ccxt-plugins   # Claude Code
npx -y ccxt-mcp                                                    # any MCP host (Node.js 20+)
```

For setup in each host, the safety model and how to enable trading, see the [local server docs](https://docs.ccxt.com/docs/mcp#local-server).

## What's inside

| Plugin | For | Gives your assistant |
|---|---|---|
| [`ccxt`](claude/ccxt) | Claude, Claude Code, Codex, ChatGPT ([OpenAI copy](chatgpt/ccxt)) | the hosted server, a skill for using it, and the CCXT coding skills: `ccxt-typescript`, `ccxt-python`, `ccxt-php`, `ccxt-csharp`, `ccxt-go`, `ccxt-java`, `ccxt-rust`, `ccxt-cli` |
| [`ccxt-local`](claude/ccxt-local) | Claude Code | the CCXT server on your computer (`npx -y ccxt-mcp`) and its skill |

The plugins are thin: manifests, skills and icons, with no CCXT code, so installing one downloads a few kilobytes rather than the CCXT codebase. The source of truth is [ccxt/ccxt](https://github.com/ccxt/ccxt): `mcp/hosted/plugin`, `mcp/plugin` and `.claude/skills`. Full docs: [docs.ccxt.com/docs/mcp](https://docs.ccxt.com/docs/mcp). Report problems at [ccxt/ccxt issues](https://github.com/ccxt/ccxt/issues).

**Privacy.** The hosted server receives the tool calls your assistant makes (tool names and arguments such as exchange, symbol and timeframe), never your conversation. It accepts no credentials and records anonymous usage analytics without IP addresses. [Details](https://docs.ccxt.com/docs/mcp#privacy).

## Updating

Claude Code doesn't auto-update plugins from this marketplace by default. Run `claude plugin update ccxt@ccxt` (and `ccxt-local@ccxt`), or turn on auto-update for the `ccxt` marketplace under `/plugin` > **Marketplaces**.

<details>
<summary><b>For maintainers: keeping in sync with ccxt/ccxt</b></summary>

Every skill here is a copy from ccxt/ccxt `master`; the list of skills each plugin ships is fixed in [`scripts/sync-from-ccxt.sh`](scripts/sync-from-ccxt.sh). [`sync-from-ccxt.yml`](.github/workflows/sync-from-ccxt.yml) runs it every six hours (or by hand from the Actions tab, on `main`), raises the patch version of each plugin that changed, and commits to `main`. Edit skills in ccxt/ccxt, not here: the next sync overwrites a change made here. If a listed skill is renamed or removed upstream, the sync fails until the list is updated.

Manifests and READMEs are maintained here, not copied. Claude Code only updates an installed plugin when its `version` changes, so a PR that changes anything a plugin ships must raise that plugin's version (`python3 scripts/bump-version.py <manifest>`); [`check-versions.yml`](.github/workflows/check-versions.yml) fails the PR otherwise, and validates the manifests.

Marketplace files: [`.claude-plugin/marketplace.json`](.claude-plugin/marketplace.json) for Claude, [`.agents/plugins/marketplace.json`](.agents/plugins/marketplace.json) for ChatGPT and Codex. The README artwork is in [`.github/assets`](.github/assets); the demo is recorded from the real views against the production server.

</details>

## License

MIT, as CCXT.
