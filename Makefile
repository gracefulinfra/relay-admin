SHELL := /bin/bash
.DEFAULT_GOAL := help

NAME := relay-admin
IMAGE ?= ghcr.io/gracefulinfra/$(NAME)
COMMIT := $(shell git rev-parse HEAD 2>/dev/null || echo unknown)

.PHONY: help deps dev test lint build image

help: ## List targets
	@grep -E '^[a-z-]+:.*## ' $(MAKEFILE_LIST) | awk -F':.*## ' '{printf "  %-8s %s\n", $$1, $$2}'

node_modules/.modules.yaml: package.json pnpm-lock.yaml
	pnpm install --frozen-lockfile

deps: node_modules/.modules.yaml ## Install dependencies from the lockfile

dev: ## Local dev server (pending)
	@echo "PENDING: no dev server yet. React app, Playwright E2E, and axe accessibility checks arrive with P1-12."

test: deps ## Unit tests (vitest)
	pnpm test
	@echo "PENDING: React app, Playwright E2E, and axe accessibility checks arrive with P1-12."

lint: deps ## ESLint, Prettier, and tsc
	pnpm lint
	pnpm typecheck

build: deps ## Compile TypeScript into dist/
	pnpm build

image: ## Build the image for the local platform and load it into Docker
	docker buildx build --load --build-arg VERSION=dev --build-arg COMMIT=$(COMMIT) -t $(IMAGE):dev .
