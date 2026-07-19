# drt sandbox

This is a sandbox environment for testing drt as an end user.

## Setup

Install drt and activate the environment:

```bash
pip install drt-core
# or with extras: drt-core[bigquery], drt-core[sheets]
```

## Available Skills (slash commands)

- `/drt-init` — Initialize a new drt project
- `/drt-create-sync` — Create a sync YAML interactively
- `/drt-debug` — Debug a failing sync
- `/drt-migrate` — Migrate from Census/Hightouch/etc. to drt

## Quick Test

```bash
drt validate    # validate config
drt list        # list syncs
drt run --dry-run  # test without sending data
drt docs generate  # v0.8.0: lineage catalog site -> target/docs/
```
