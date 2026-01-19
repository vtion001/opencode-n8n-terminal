# n8n Terminal Quick Start

Quick reference guide for daily n8n terminal workflow management.

---

## Daily Usage

### Start n8n Environment

```bash
~/Desktop/Notes/n8n-documentations/start-n8n.sh
```

Or add shell config and use:
```bash
n8n-startup
```

---

## Common Commands

### Workflow Management

```bash
# List all workflows
n8n workflows list

# Create workflow from file
n8n workflows create --file workflow.json

# Get workflow details
n8n workflows get <WORKFLOW_ID>

# Activate workflow
n8n workflows activate --ids <WORKFLOW_ID> --force

# Deactivate workflow
n8n workflows deactivate --ids <WORKFLOW_ID> --force

# Delete workflow
n8n workflows delete --ids <WORKFLOW_ID> --force
```

### Using Aliases (after shell config)

```bash
n8n-list                  # List all workflows
n8n-create workflow.json    # Create workflow
n8n-activate <ID>        # Activate workflow
n8n-get <ID>             # Get workflow details
n8n-delete <ID>         # Delete workflow
```

---

## Docker Management

```bash
# Start n8n container
docker start n8n

# Stop n8n container
docker stop n8n

# Restart n8n container
docker restart n8n

# View logs
docker logs n8n

# Check status
docker ps | grep n8n
```

### Using Aliases

```bash
n8n-start                  # Start n8n
n8n-stop                   # Stop n8n
n8n-restart                # Restart n8n
n8n-logs                   # View logs
n8n-status                 # Check status
```

---

## Health & Validation

```bash
# Check n8n connection
n8n health

# Validate workflow file
n8n workflows validate workflow.json

# Auto-fix workflow issues
n8n workflows autofix workflow.json
```

---

## Workflow Templates

Available templates in `~/Desktop/Notes/n8n-documentations/workflow-templates/`:

```bash
# List templates
n8n-templates-list

# Use template
n8n-use-template simple-schedule.json
```

Templates:
- `simple-schedule.json` - Hourly scheduled task
- `webhook-echo.json` - Webhook responder
- `data-processing.json` - Data transformation

---

## Execution Management

```bash
# List all executions
n8n executions list

# List workflow executions
n8n executions list --workflow-id <WORKFLOW_ID>
```

---

## Quick Workflow Example

### Create a Simple Scheduled Workflow

```bash
# 1. Copy template
cp ~/Desktop/Notes/n8n-documentations/workflow-templates/simple-schedule.json my-workflow.json

# 2. Edit if needed
vim my-workflow.json

# 3. Validate
n8n workflows validate my-workflow.json

# 4. Create
n8n workflows create --file my-workflow.json

# 5. Activate (replace ID with actual ID)
n8n workflows activate --ids <WORKFLOW_ID> --force
```

---

## Authentication

```bash
# Login to n8n
n8n auth login -H http://localhost:5678 -k YOUR_API_KEY

# Check status
n8n auth status

# Logout
n8n auth logout
```

---

## File Locations

- **Documentation:** ~/Desktop/Notes/n8n-documentations/
- **Templates:** ~/Desktop/Notes/n8n-documentations/workflow-templates/
- **Startup Script:** ~/Desktop/Notes/n8n-documentations/start-n8n.sh
- **Shell Config:** ~/Desktop/Notes/n8n-documentations/shell-config.sh
- **Config:** ~/.n8nrc.json

---

## Troubleshooting

### Docker not running

```bash
# Check Docker
docker ps

# Start Docker Desktop (macOS) or Docker service (Linux)
```

### n8n not ready

```bash
# Check health
curl http://localhost:5678/healthz

# Start container
docker start n8n
```

### Authentication issues

```bash
# Re-authenticate
n8n auth logout
n8n auth login -H http://localhost:5678 -k YOUR_API_KEY
```

---

## Help Resources

- **n8n Docs:** https://docs.n8n.io
- **n8n-CLI Help:** n8n --help
- **Community:** https://community.n8n.io

---

**For full documentation, see [README.md](README.md)**
