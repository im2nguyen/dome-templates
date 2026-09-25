# Motivational Haiku

This template provisions a Dome Gateway, Anthropic Haiku model pool, chat
agent, and runtime token. The agent responds to each prompt with one original,
encouraging 5–7–5 haiku.

## Run locally

```sh
npx @domesystems/templates generate --dir . --force
dome import dome.tf --plan-only
dome import dome.tf
dome import outputs <job-id>
cp .env.example .env
npx @domesystems/templates up --dir . --skip-provision
```

`anthropic_api_key` is supplied to Dome during import and is not stored in this
repository.

## Publish

```sh
npx @domesystems/templates doctor publish --registry https://templates-registry-dev.domesystems.ai
npx @domesystems/templates publish --registry https://templates-registry-dev.domesystems.ai
```
