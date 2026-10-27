# TinyFish setup notes

1. Go to [tinyfish.ai](https://www.tinyfish.ai/).
2. Create an account, then create or copy your TinyFish API key.
3. In the Sandbox deployment form, paste it into **tinyfish_api_key** with
   `Bearer ` prepended. For example: `Bearer your-api-key`.
4. Paste your Anthropic API key into **anthropic_api_key**, then review the
   generated plan before deploying.

The deployed agent receives access only to TinyFish `search` and
`fetch_content`. It does not receive browser automation, account access, or
raw browser-session tools.
