# n8n Terminal Environment - Daily Usage Guide

Quick reference for everyday n8n terminal operations.

---

## Daily Startup

### Option 1: Run Startup Script (Recommended)

```bash
# Navigate to documentation
cd ~/Desktop/Notes/n8n-documentations

# Run startup script
./start-n8n.sh
```

### Option 2: Using Aliases (After Shell Config)

```bash
# Start n8n
n8n-startup

# Check status
n8n-health
```

---

## Common Operations

### List Workflows

```bash
# Full command
n8n workflows list

# Using alias
n8n-list
```

### Create Workflow

```bash
# Using template
n8n-use-template simple-schedule.json

# Create from file
n8n workflows create --file my-workflow.json

# Using alias
n8n-create my-workflow.json
```

### Activate Workflow

```bash
# Find workflow ID first
n8n workflows list

# Activate by ID
n8n workflows activate --ids <WORKFLOW_ID> --force

# Using alias
n8n-activate <WORKFLOW_ID> --force
```

### View Workflow Details

```bash
n8n workflows get <WORKFLOW_ID>

# Using alias
n8n-get <WORKFLOW_ID>
```

### Delete Workflow

```bash
n8n workflows delete --ids <WORKFLOW_ID> --force

# Using alias
n8n-delete <WORKFLOW_ID> --force
```

---

## Docker Operations

### Start/Stop/Restart

```bash
# Start
docker start n8n

# Stop
docker stop n8n

# Restart
docker restart n8n

# Using aliases
n8n-start
n8n-stop
n8n-restart
```

### View Logs

```bash
docker logs n8n

# Using alias
n8n-logs

# Follow logs (real-time)
docker logs -f n8n
```

---

## Workflow Templates

### Available Templates

```bash
# List templates
n8n-templates-list

# Or list files
ls ~/Desktop/Notes/n8n-documentations/workflow-templates/
```

### Use a Template

```bash
# Copy template to current directory
n8n-use-template simple-schedule.json

# Or manually
cp ~/Desktop/Notes/n8n-documentations/workflow-templates/simple-schedule.json my-workflow.json
```

### Template Descriptions

1. **simple-schedule.json**
   - Type: Scheduled task
   - Triggers: Every hour
   - Actions: HTTP request to GitHub API

2. **webhook-echo.json**
   - Type: Webhook
   - Triggers: POST requests
   - Actions: Responds with received data and timestamp

3. **data-processing.json**
   - Type: Manual trigger
   - Triggers: Manual execution
   - Actions: Set fields, transform data

---

## Quick Examples

### Example 1: Create Simple Workflow

```bash
# 1. Copy template
n8n-use-template simple-schedule.json

# 2. Edit if needed
vim simple-schedule.json

# 3. Validate
n8n workflows validate simple-schedule.json

# 4. Create
n8n workflows create --file simple-schedule.json

# 5. Activate (replace ID with actual ID)
n8n workflows activate --ids <ID> --force
```

### Example 2: Test Webhook

```bash
# 1. Copy webhook template
n8n-use-template webhook-echo.json

# 2. Create workflow
n8n workflows create --file webhook-echo.json

# 3. Activate
n8n workflows activate --ids <ID> --force

# 4. Test webhook
curl -X POST http://localhost:5678/webhook/webhook-echo \
  -H "Content-Type: application/json" \
  -d '{"message":"test"}'
```

### Example 3: View Executions

```bash
# List all executions
n8n executions list

# List workflow executions
n8n executions list --workflow-id <WORKFLOW_ID>
```

---

## Health & Validation

### Check n8n Health

```bash
n8n health

# Expected output:
# ╭─ 🏥 n8n Health Check
# ╰─
# ✅ Connection: OK
# ✅ API Key: Valid
```

### Validate Workflow

```bash
n8n workflows validate workflow.json

# Auto-fix issues
n8n workflows autofix workflow.json --save fixed.json
```

---

## Authentication

### Login

```bash
n8n auth login -H http://localhost:5678 -k YOUR_API_KEY
```

### Check Status

```bash
n8n auth status
```

### Logout

```bash
n8n auth logout
```

---

## Shell Setup (One-time)

### Add Shell Configuration

```bash
# Add to ~/.bashrc or ~/.zshrc
cat >> ~/.bashrc << 'EOF'

# n8n Terminal Environment
source ~/Desktop/Notes/n8n-documentations/shell-config.sh
EOF

# Reload shell
source ~/.bashrc
```

### Test Aliases

```bash
# Test a few aliases
n8n-health
n8n-list
n8n-startup
```

---

## File Locations

- **Documentation:** ~/Desktop/Notes/n8n-documentations/
- **Templates:** ~/Desktop/Notes/n8n-documentations/workflow-templates/
- **Startup Script:** ~/Desktop/Notes/n8n-documentations/start-n8n.sh
- **Config:** ~/.n8nrc.json

---

## Help & Resources

### Quick Help

```bash
# n8n-cli help
n8n --help

# Specific command help
n8n workflows --help
n8n executions --help
```

### Documentation

- [README.md](README.md) - Complete setup guide
- [INSTALLATION.md](INSTALLATION.md) - Step-by-step installation
- [QUICK_START.md](QUICK_START.md) - Quick reference

### Online Resources

- n8n Docs: https://docs.n8n.io
- n8n CLI: https://github.com/yigitkonur/n8n-cli
- n8n Community: https://community.n8n.io

---

## Troubleshooting

### Docker Not Running

```bash
# Check status
docker ps | grep n8n

# Start if needed
docker start n8n

# Start Docker Desktop (macOS)
open -a Docker
```

### Connection Issues

```bash
# Test connection
curl http://localhost:5678/healthz

# Check logs
docker logs n8n

# Re-authenticate
n8n auth login -H http://localhost:5678 -k YOUR_API_KEY
```

### Workflow Not Creating

```bash
# Validate first
n8n workflows validate workflow.json

# Check for errors
n8n workflows validate workflow.json --json

# Use auto-fix
n8n workflows autofix workflow.json --save fixed.json
```

---

**End of Usage Guide**

For complete documentation, see [README.md](README.md)
