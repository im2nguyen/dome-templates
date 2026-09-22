# Dome templates

Publishable, importable Dome templates maintained by
[@im2nguyen](https://github.com/im2nguyen).

## Templates

| Template | Package |
| --- | --- |
| `templates/hello-dome` | `im2nguyen/hello-dome` |

## Run a template locally

Each template includes `dome.tf`, which creates its Dome Gateway, model pool,
agent, and a runtime token. Install the Dome CLI and authenticate before the
first run:

```sh
brew install dome-systems/tap/dome
dome auth login
dome sandbox provision

cd templates/hello-dome
dome import dome.tf --plan-only
dome import dome.tf
```

The import prints a job ID. Retrieve the generated agent token, then put the
token and Gateway URL in a local `.env` file (it is ignored by Git):

```sh
dome import outputs <job-id>
cp .env.example .env
# Edit .env with the returned DOME_TOKEN and DOME_GATEWAY_URL values.

local-templates up --dir . --skip-provision
```

`local-templates up` always writes a generated `.dome-compose.yaml` and starts
the runtime. When `.env` does not have both `DOME_TOKEN` and
`DOME_GATEWAY_URL`, it first runs `dome import dome.tf`; use
`--skip-provision` only after you have imported the resources yourself. Docker
Compose is required to start the local runtime.

## Publish a release

Each package has its own `template.yaml`. Releases are immutable, so increase
`metadata.version` before publishing another release.

```sh
cd templates/hello-dome
local-templates doctor publish --server https://app.dev.domesystems.ai
local-templates publish --server https://app.dev.domesystems.ai
```

The checkout must be committed and clean. The first publish also requires a
Registry login with the GitHub App linked to this repository. Registry
publishing packages the template source; it does not import Dome resources.
