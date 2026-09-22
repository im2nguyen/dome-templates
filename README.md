# Dome templates

Publishable Dome templates maintained by [@im2nguyen](https://github.com/im2nguyen).

## Templates

| Template | Package |
| --- | --- |
| `templates/hello-dome` | `im2nguyen/hello-dome` |

## Publish a release

Each package has its own `template.yaml`. Releases are immutable, so increase
`metadata.version` before publishing another release.

```sh
cd templates/hello-dome
local-templates doctor publish --server https://app.dev.domesystems.ai
local-templates publish --server https://app.dev.domesystems.ai
```

The checkout must be committed and clean. The first publish also requires a
Registry login with the GitHub App linked to this repository.

