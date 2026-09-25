# syntax=docker/dockerfile:1
# Bootstrap smoke image (P0-01). Base images are pinned by digest; Renovate keeps them current.
FROM --platform=$BUILDPLATFORM node:24.21.0-trixie-slim@sha256:8ec5d7557396cfe32d21c3f9c13072355ceab22b584578ca4bb28af31120cffe AS build
WORKDIR /src
RUN corepack enable
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile
COPY . .
RUN pnpm build

FROM gcr.io/distroless/nodejs24-debian13:nonroot@sha256:bb6b03d81066993293a10feda7250e8e1cc034035fe9b61cfceededa7c8bf04d
ARG VERSION=dev COMMIT=unknown
ENV RELAY_VERSION=$VERSION RELAY_COMMIT=$COMMIT NODE_ENV=production
WORKDIR /app
COPY --from=build /src/dist/ ./
USER nonroot:nonroot
CMD ["smoke.js"]
