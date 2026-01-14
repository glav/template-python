# template-python (copilotplay)

This repository is a small, intentionally minimal Python template you can use as the starting point for new repos.

It’s designed to bequick workflow to get started while keeping the day-0 developer experience solid (devcontainer support, modern dependency management, and a place for agent instructions).

## What this template includes

- Python 3.12 devcontainer setup
- `uv` for dependency management (`pyproject.toml` + `uv.lock`)
- A tiny runnable entrypoint (`src/app.py`) that loads environment variables from `.env` via `python-dotenv`
- `AGENTS.md` for coding-agent guidance

## Using this repo as a template

Typical workflow:

1. Create a new repository from this template (GitHub: “Use this template”).
2. Update project metadata in `pyproject.toml` (name/description).
3. Replace the sample app code under `src/` with your real project.
4. Update `AGENTS.md` and this README to reflect the new repo’s purpose.

## Setup

This repo uses `uv`.

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
uv sync
```

## Run

```bash
uv run python src/app.py
```

## Environment variables

- Copy `.env-sample` to `.env` and fill in values as needed.
- `.env` is gitignored.

```bash
cp .env-sample .env
```
