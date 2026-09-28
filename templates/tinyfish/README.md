# TinyFish live-web researcher

This unlisted template deploys a Dome-managed agent that researches the open
web using TinyFish. Its gateway exposes only `search` and `fetch_content`; no
browser automation, account access, or raw browser-session tools are attached.

Provide a TinyFish API key and Anthropic API key during deployment. The keys
are stored by Dome in shared connections and are not available to the agent.

The release can be installed by its exact package name,
`im2nguyen/tinyfish`, but it is intentionally absent from normal
Library browsing.
