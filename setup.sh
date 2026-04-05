#!/bin/bash
# Set up the drt sandbox environment
set -e

echo "=== drt sandbox setup ==="

# Check if drt is installed
if ! command -v drt &> /dev/null; then
  echo "drt not found. Installing..."
  pip install drt-core
fi

# Verify drt is available
echo "drt version: $(drt --version 2>/dev/null || echo 'not found')"

# Create a sample DuckDB database with demo data
if [ ! -f sandbox.duckdb ]; then
  echo ""
  echo "Creating sample DuckDB database..."
  python3 -c "
import duckdb
con = duckdb.connect('sandbox.duckdb')
con.execute('''
  CREATE TABLE users (
    id INTEGER,
    name VARCHAR,
    email VARCHAR,
    department VARCHAR
  )
''')
con.execute('''
  INSERT INTO users VALUES
    (1, 'Alice',   'alice@example.com',   'Engineering'),
    (2, 'Bob',     'bob@example.com',     'Marketing'),
    (3, 'Charlie', 'charlie@example.com', 'Sales'),
    (4, 'Diana',   'diana@example.com',   'Engineering'),
    (5, 'Eve',     'eve@example.com',     'Product')
''')
con.execute('''
  CREATE TABLE orders (
    id INTEGER,
    user_id INTEGER,
    product VARCHAR,
    amount INTEGER,
    ordered_at TIMESTAMP
  )
''')
con.execute('''
  INSERT INTO orders VALUES
    (101, 1, 'Widget A',  1200, '2026-04-01 10:00:00'),
    (102, 2, 'Widget B',  3400, '2026-04-01 11:30:00'),
    (103, 1, 'Widget C',  5600, '2026-04-02 09:15:00'),
    (104, 3, 'Widget A',  1200, '2026-04-02 14:00:00'),
    (105, 4, 'Widget D',  7800, '2026-04-03 16:45:00')
''')
con.close()
  "
  echo "  Created sandbox.duckdb with 'users' and 'orders' tables"
fi

# Init a sample project if drt_project.yml doesn't exist
if [ ! -f drt_project.yml ]; then
  echo ""
  echo "No drt_project.yml found. Run 'drt init' or '/drt-init' in Claude to set up."
fi

echo ""
echo "Ready! Try these commands:"
echo "  drt validate"
echo "  drt list"
echo "  drt run --dry-run"
echo ""
echo "Or run 'claude' to start testing skills:"
echo "  /drt-init, /drt-create-sync, /drt-debug, /drt-migrate"
