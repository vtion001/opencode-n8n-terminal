# n8n Terminal Workflow Management - Complete Setup Guide

Complete documentation for running n8n with Docker, n8n-cli, and terminal-based workflow management.

**Last Updated:** 2026-01-18
**Version:** 1.0.0
**Location:** ~/Desktop/Notes/n8n-documentations

---

## Quick Start

### Daily Usage

```bash
# Start n8n environment
~/Desktop/Notes/n8n-documentations/start-n8n.sh
```

### First Time Setup

```bash
# 1. Navigate to documentation
cd ~/Desktop/Notes/n8n-documentations

# 2. Run startup script
./start-n8n.sh

# 3. Follow prompts for authentication (first time only)
```

---

## Overview

This setup enables terminal-based n8n workflow management without using the web interface.

### Components

- **n8n (Docker):** Automation platform running on port 5678
- **n8n-cli:** Command-line tool for workflow management
- **Workflow Templates:** Ready-to-use workflow JSON files
- **Startup Scripts:** Automated initialization on computer boot

### Benefits

- Terminal-based workflow management
- No web interface required for daily operations
- CI/CD ready
- Automated startup scripts
- Full CRUD operations via CLI
- Quick aliases for common operations

---

## Docker Setup

### Start n8n Docker Container

```bash
# Create data volume for persistence
docker volume create n8n_data

# Run n8n container
docker run -d \
  --restart always \
  --name n8n \
  -p 5678:5678 \
  -e GENERIC_TIMEZONE="UTC" \
  -e TZ="UTC" \
  -e N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true \
  -e N8N_RUNNERS_ENABLED=true \
  -v n8n_data:/home/node/.n8n \
  docker.n8n.io/n8nio/n8n
```

### Docker Management Commands

```bash
# Start n8n
docker start n8n

# Stop n8n
docker stop n8n

# Restart n8n
docker restart n8n

# View logs
docker logs n8n

# Check status
docker ps | grep n8n
```

---

## n8n-CLI Installation

### Install n8n-cli Globally

```bash
# Install via npm
npm install -g n8n-cli

# Verify installation
n8n --version
```

### Authenticate with n8n Instance

**Getting Your API Key:**

1. Open http://localhost:5678 in browser
2. Create admin account (first time setup)
3. Go to Settings → API Keys → Create API Key
4. Copy the generated API key

**Login:**
```bash
n8n auth login -H http://localhost:5678 -k YOUR_API_KEY

# Verify authentication
n8n auth status

# Check connection
n8n health
```

---

## Shell Configuration

### Quick Setup

```bash
# Add to your shell config
cat >> ~/.bashrc << 'EOF'

# n8n Terminal Environment
source ~/Desktop/Notes/n8n-documentations/shell-config.sh
EOF

# Reload shell
source ~/.bashrc
```

### Available Aliases

After configuring shell, you can use these shortcuts:

```bash
# Workflow Management
n8n-list                  # List all workflows
n8n-create <file>         # Create workflow from file
n8n-activate <id>          # Activate workflow (use --force)
n8n-get <id>               # Get workflow details
n8n-health                 # Check n8n connection

# Docker Management
n8n-start                  # Start n8n container
n8n-stop                   # Stop n8n container
n8n-restart                # Restart n8n container
n8n-logs                   # View n8n logs

# Quick Access
n8n-docs                  # Navigate to documentation directory
n8n-startup               # Run startup script
n8n-templates             # Navigate to workflow templates
```

---

## Workflow Creation

### Creating a Workflow

```bash
# 1. Use a template
n8n-use-template simple-schedule.json my-workflow.json

# 2. Edit the workflow
vim my-workflow.json

# 3. Validate workflow
n8n-validate my-workflow.json

# 4. Create workflow
n8n-create my-workflow.json

# 5. Activate workflow
n8n-activate <WORKFLOW_ID> --force
```

---

## Quick Reference

### n8n-CLI Commands

```bash
# Workflows
n8n workflows list                 # List all workflows
n8n workflows create --file <file>  # Create workflow
n8n workflows activate --ids <id>  # Activate workflow
n8n workflows deactivate --ids <id>  # Deactivate workflow

# Health
n8n health                        # Check connection
```

---

## Support

For issues or questions:
1. Visit [n8n Community](https://community.n8n.io)
2. Open an issue on [n8n-CLI GitHub](https://github.com/yigitkonur/n8n-cli/issues)
3. Check [n8n Documentation](https://docs.n8n.io)

---

**End of Documentation**
