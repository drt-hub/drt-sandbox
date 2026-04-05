# drt-sandbox

A clean sandbox environment to try [drt](https://github.com/datareversetech/drt) -- the open-source Reverse ETL framework.

## Prerequisites

- Python 3.10+
- pip (or uv)
- [duckdb](https://pypi.org/project/duckdb/) Python package (installed automatically with drt)

## Quick Start

```bash
# Clone the sandbox
git clone https://github.com/datareversetech/drt-sandbox.git
cd drt-sandbox

# Run setup (installs drt, creates sample DuckDB database)
chmod +x setup.sh cleanup.sh
./setup.sh

# Try drt commands
drt validate          # Validate project config
drt list              # List configured syncs
drt run --dry-run     # Test run without sending data
drt run               # Run all syncs
drt status            # Check run results
```

## What's Included

| File | Description |
|------|-------------|
| `drt_project.yml` | Project configuration (points to the `sandbox` profile) |
| `syncs/example_users.yml` | Example sync: sends users to httpbin.org (safe for testing) |
| `setup.sh` | Creates a sample DuckDB database with `users` and `orders` tables |
| `cleanup.sh` | Resets the sandbox to a clean state |
| `CLAUDE.md` | Instructions for Claude Code (slash commands) |
| `.claude/commands/` | Claude Code skills: `/drt-init`, `/drt-create-sync`, `/drt-debug`, `/drt-migrate` |

## Using with Claude Code

If you have [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed, you can use the built-in slash commands:

```
/drt-init          # Initialize a new drt project
/drt-create-sync   # Create a sync YAML interactively
/drt-debug         # Debug a failing sync
/drt-migrate       # Migrate from Census/Hightouch/etc. to drt
```

## Sample Data

`setup.sh` creates a DuckDB database (`sandbox.duckdb`) with two tables:

**users** -- 5 sample users with name, email, and department

**orders** -- 5 sample orders with product, amount, and timestamp

## Security Note

This repository contains no real credentials or production data. All API endpoints use safe public services (e.g., httpbin.org). Secrets are referenced via environment variables (`*_env` fields) and are never hardcoded in sync files.

## Links

- [drt (main repo)](https://github.com/datareversetech/drt)
- [drt documentation](https://github.com/datareversetech/drt#readme)
- [drt on PyPI](https://pypi.org/project/drt-core/)

## License

MIT
