# Vercel AI Gateway chat

A Dome-managed chat agent that sends model requests through Vercel AI Gateway. It uses Vercel's OpenAI-compatible endpoint, while Dome supplies the shared `Authorization: Bearer …` credential and governs the agent's model access.

## What you need

- A Vercel AI Gateway API key for the team that should own usage, spend, and routing data.
- A Vercel AI Gateway model available to that key. The template defaults to Z.ai's flagship `zai/glm-5.3`.
- The Dome CLI.

## Run locally

```sh
brew install dome-systems/tap/dome
dome auth login
dome sandbox provision

npx @domesystems/templates generate --dir . --force
dome import dome.tf --plan-only
dome import dome.tf
```

Pass `vercel_ai_gateway_api_key` only to the Dome import prompt. It is stored in Dome's shared model connection. Once the import completes, open the managed agent in Dome to chat with it.

## Customize the model

Before generating Terraform, update `models[0].provider_config.model` in `dome.yaml` to another model ID available through your Vercel AI Gateway team. Keep the `openai_compatible` provider and the `https://ai-gateway.vercel.sh/v1` endpoint unchanged.

## Publish

```sh
npx @domesystems/templates doctor publish --registry https://templates-registry-dev.domesystems.ai
npx @domesystems/templates publish --registry https://templates-registry-dev.domesystems.ai
```

Increase `metadata.version` in `dome.yaml` before publishing another release.
