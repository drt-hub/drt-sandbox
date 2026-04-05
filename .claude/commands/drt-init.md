
Guide the user through initializing a new drt project.

## Steps

1. Confirm the user has drt installed:
   ```bash
   pip install drt-core   # or with extras: drt-core[bigquery], drt-core[sheets]
   # or
   uv add drt-core
   ```

2. Run `drt init` to set up the project:
   ```bash
   drt init
   ```
   This will prompt for:
   - Project name
   - Source type (bigquery / duckdb / postgres / redshift / sqlite)
   - Source-specific settings (e.g. GCP project for BigQuery, database path for DuckDB)
   - Auth method

3. This creates:
   ```
   my-drt-project/
   ├── drt_project.yml
   └── syncs/
       └── example_sync.yml
   ```
   And writes credentials to `~/.drt/profiles.yml`.

4. Validate the setup:
   ```bash
   drt validate
   drt list
   ```

5. Offer to create a first sync using the `/drt-create-sync` command.

## Tips

- `drt_project.yml` selects which profile from `~/.drt/profiles.yml` to use
- Put each sync in a separate `syncs/<name>.yml` file
- Use `drt run --dry-run` to test without writing data
- Use `drt status` to check recent run results
