# Hello Dome

This small template is intentionally dependency-free: it has no external tools
and is useful for proving the Registry login, publish, pull, import, and local
runtime flow. Its `dome.tf` creates a Gateway, an Anthropic Haiku model pool,
an agent, and a runtime token.

## Run locally

```sh
# Install and configure the Dome CLI once.
brew install dome-systems/tap/dome
dome auth login
dome sandbox provision

# Preview, then create the resources. Dome prompts for workspace_id and
# anthropic_api_key; the latter is stored in Dome, never in this repository.
dome import dome.tf --plan-only
dome import dome.tf

# Fetch the runtime credentials from the returned job ID.
dome import outputs <job-id>
cp .env.example .env
# Edit .env with DOME_TOKEN and DOME_GATEWAY_URL from the import output.

# Start the generated Compose runtime without re-importing resources.
local-templates up --dir . --skip-provision
```

For a configuration-only check, use `local-templates up --dir . --no-start`.
The runtime can also start in offline mode without a token, but it cannot make
live model requests until the `.env` credentials are configured.

## Publish

```sh
local-templates login --server https://app.dev.domesystems.ai --github
local-templates doctor publish --server https://app.dev.domesystems.ai
local-templates publish --server https://app.dev.domesystems.ai
```

The template directory must be committed and clean. Increase
`metadata.version` in `template.yaml` for every subsequent release.
