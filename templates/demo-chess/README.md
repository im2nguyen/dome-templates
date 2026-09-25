# Demo Chess

This is a two-agent template: `chess-coach` acts on behalf of an approved
player and gives position advice; `opponent-stockfish` selects the Black move
without caller identity. Both agents share a gateway, Stockfish MCP connection,
and approved model pools, while retaining separate Cedar rules, keys, and
spend quotas.

The template expects a reachable Stockfish MCP endpoint. Supply its public
`/mcp` URL as `stockfish_mcp_url` during import, alongside an Anthropic API key
and the HMAC secret used by the coach's act-as policy.

## Generate and import

```sh
npx @domesystems/templates generate --dir . --force
dome import dome.tf --plan-only
dome import dome.tf
```

The import output contains one token for each external agent. The separate
agent configurations under `agents/` show the intended coach and opponent
runtime settings for a host application.
