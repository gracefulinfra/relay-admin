# relay-admin

Relay's producer and editor app (React, Vite, TanStack Router and Query).

Part of **Relay**, a cloud-agnostic podcast network platform built as a portfolio project.
The build is driven by a prompt series; see the prompt index (`prompts/00-INDEX.md` in the planning
workspace) and the architecture decisions in
[relay-contracts/adr](https://github.com/gracefulinfra/relay-contracts/tree/main/adr).

## Status

Bootstrapped by **P0-01**. This repo contains only the CI and tooling skeleton; there is no product code yet.

## Quickstart

Prerequisites: see [relay-contracts/docs/version-matrix.md](https://github.com/gracefulinfra/relay-contracts/blob/main/docs/version-matrix.md).

```bash
git clone https://github.com/gracefulinfra/relay-admin.git
cd relay-admin
make test
make lint
```

| Target       | What it does today                                                                                              |
| ------------ | --------------------------------------------------------------------------------------------------------------- |
| `make test`  | Vitest unit tests (build-info only). React app, Playwright E2E, and axe accessibility checks arrive with P1-12. |
| `make lint`  | ESLint (`strictTypeChecked`), Prettier check, and `tsc --noEmit`                                                |
| `make build` | Compiles the smoke entrypoint into `dist/`                                                                      |
| `make image` | Builds the smoke image for your platform                                                                        |
| `make dev`   | Pending: prints a notice and exits 0                                                                            |

Node is pinned in `.nvmrc` (`nvm use`), and pnpm in `package.json` (`packageManager`).

## CI

`.github/workflows/ci.yml` runs `check` (install from the lockfile, lint, typecheck, and Vitest) on every
PR and push. The `image` job builds `linux/amd64` and `linux/arm64` images on PRs without pushing. On
`main` it pushes `ghcr.io/gracefulinfra/relay-admin:<git-sha>`, signs the image with cosign keyless, and
attaches a syft SPDX SBOM. See
[relay-contracts/docs/ci.md](https://github.com/gracefulinfra/relay-contracts/blob/main/docs/ci.md).
