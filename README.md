# Dome templates

Publishable, importable Dome templates maintained by
[@im2nguyen](https://github.com/im2nguyen).

## Templates

| Template | Package |
| --- | --- |
| `templates/hello-dome` | `im2nguyen/hello-dome` |
| `templates/haiku` | `im2nguyen/haiku` |
| `templates/demo-chess` | `im2nguyen/demo-chess` |

## Run a template locally

`template.yaml` is the source of truth. Generate `dome.tf` from it before an
import; the generated Terraform creates the gateways, connections, model pools,
agents, keys, and governance controls declared by the template. Install the
Dome CLI and authenticate before the first run:

```sh
brew install dome-systems/tap/dome
dome auth login
dome sandbox provision

cd templates/hello-dome
npx @domesystems/templates generate --dir . --force
dome import dome.tf --plan-only
dome import dome.tf
```

The import prints a job ID. Retrieve the generated agent token, then put the
token and Gateway URL in a local `.env` file (it is ignored by Git):

```sh
dome import outputs <job-id>
cp .env.example .env
# Edit .env with the returned DOME_TOKEN and DOME_GATEWAY_URL values.

npx @domesystems/templates up --dir . --skip-provision
```

`npx @domesystems/templates up` always writes a generated `.dome-compose.yaml` and starts
the runtime. When `.env` does not have both `DOME_TOKEN` and
`DOME_GATEWAY_URL`, it first runs `dome import dome.tf`; use
`--skip-provision` only after you have imported the resources yourself. Docker
Compose is required to start the local runtime.

## Publish a release

Each package has its own `template.yaml`. Releases are immutable, so increase
`metadata.version` before publishing another release.

```sh
cd templates/hello-dome
npx @domesystems/templates doctor publish --server https://templates-registry-dev.domesystems.ai
npx @domesystems/templates publish --server https://templates-registry-dev.domesystems.ai
```

The checkout must be committed and clean. The first publish also requires a
Registry login with the GitHub App linked to this repository. Registry
publishing packages the template source; it does not import Dome resources.
