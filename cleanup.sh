#!/bin/bash
# Clean up sandbox: remove generated state and data, keep structure
set -e

echo "=== Cleaning up sandbox ==="

# Remove drt state
rm -rf .drt/state/ .drt/state.json .drt_state/
echo "  Removed drt state"

# Remove DuckDB database (can be recreated by setup.sh)
rm -f sandbox.duckdb sandbox.duckdb.wal
rm -rf target/          # generated docs site (drt docs generate)
echo "  Removed sandbox.duckdb"

# Remove generated syncs (keep example)
find syncs/ -name '*.yml' ! -name 'example_users.yml' -delete 2>/dev/null
echo "  Cleaned syncs/ (kept example_users.yml)"

echo ""
echo "Done. Run ./setup.sh to recreate."
