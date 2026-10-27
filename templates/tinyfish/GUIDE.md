Go to [TinyFish](https://www.tinyfish.ai/), create an account, and create or
copy your API key. Paste it into `tinyfish_api_key` with `Bearer ` prepended,
for example `Bearer your-api-key`. Paste an Anthropic API key into
`anthropic_api_key` as well. Sandbox does not retain either value.

The deployed agent can use only TinyFish `search` and `fetch_content`; it does
not receive browser automation, account access, or raw browser-session tools.
