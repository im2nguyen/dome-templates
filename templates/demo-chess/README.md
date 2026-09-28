# Demo Chess

This is a two-agent managed template: `chess-coach` gives position advice and
`opponent-stockfish` selects the Black move. Both agents run with Dome's managed
identity and share a gateway, Stockfish MCP connection, and approved model pools,
while retaining separate Cedar rules and spend quotas.

The template expects a reachable Stockfish MCP endpoint. Supply its public
`/mcp` URL as `stockfish_mcp_url` during import, alongside an Anthropic API key.

## Generate and import

```sh
npx @domesystems/templates generate --dir . --force
dome import dome.tf --plan-only
dome import dome.tf
```

The managed agents run in Dome after import; the separate agent configurations
under `agents/` define their prompts and authorization rules.
