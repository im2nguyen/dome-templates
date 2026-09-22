# Hello Dome

This small template is intentionally dependency-free: it has no external
tools and is useful for proving the Registry login, publish, pull, and local
runtime flow.

## Run locally

```sh
cp .env.example .env
local-templates up --dir .
```

Without `DOME_TOKEN`, the runtime starts in offline mode, which is sufficient
to inspect the UI and test the local template mechanics.

