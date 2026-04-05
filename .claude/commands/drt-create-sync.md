
Create a drt sync YAML configuration file for the user.

## Steps

1. Ask the user for the following (or infer from context if already provided):
   - **Source table or SQL**: what data to sync (e.g. `ref('new_users')` or a SQL query)
   - **Destination**: where to send it (Slack, Discord, REST API, HubSpot, GitHub Actions, Google Sheets, PostgreSQL, MySQL, or other)
   - **Sync mode**: full (every run) or incremental (watermark-based, needs a cursor column)
   - **Frequency intent**: helps set `batch_size` and `rate_limit`

2. Generate a valid sync YAML. Key rules:
   - Use `type: bearer` + `token_env` (never hardcode tokens)
   - Default `on_error: skip` for Slack/webhooks, `on_error: fail` for critical syncs
   - For incremental mode, always include `cursor_field`
   - Use `ref('table_name')` when the source is a single DWH table; raw SQL when filtering or joining
   - Jinja2 templates use `{{ row.<column_name> }}` — column names must come from the user

3. Output the YAML in a code block and save it to `syncs/<name>.yml`

4. Show the command to validate and run it:
   ```bash
   drt validate
   drt run --select <name> --dry-run
   drt run --select <name>
   ```

## Destination Quick Reference

### Slack
```yaml
destination:
  type: slack
  webhook_url_env: SLACK_WEBHOOK_URL
  body_template: |
    {"text": "New user: {{ row.name }} ({{ row.email }})"}
```

### Google Sheets
```yaml
destination:
  type: google_sheets
  spreadsheet_id: "YOUR_SPREADSHEET_ID"
  sheet: "Sheet1"
  mode: overwrite
```

### Discord
```yaml
destination:
  type: discord
  webhook_url_env: DISCORD_WEBHOOK_URL
  body_template: |
    {"content": "Alert: {{ row.metric }} = {{ row.value }}"}
```

### REST API
```yaml
destination:
  type: rest_api
  url: "https://api.example.com/endpoint"
  method: POST
  auth:
    type: bearer
    token_env: API_TOKEN
  body_template: |
    {"name": "{{ row.name }}", "email": "{{ row.email }}"}
```

### PostgreSQL / MySQL
```yaml
destination:
  type: postgres  # or mysql
  connection_string_env: DATABASE_URL
  table: target_table
  mode: upsert  # or append
  primary_key: id
```