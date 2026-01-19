# n8n Terminal Setup - Installation Guide

Step-by-step guide to set up n8n terminal workflow management from scratch.

---

## Step 1: Install Prerequisites

### Install Docker

**macOS:**
```bash
brew install --cask docker
```

**Linux (Ubuntu/Debian):**
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

**Verify:**
```bash
docker --version
```

### Install Node.js and npm

```bash
# macOS (Homebrew)
brew install node

# Linux (Ubuntu/Debian)
sudo apt-get update
sudo apt-get install -y nodejs npm

# Verify
node --version
npm --version
```

---

## Step 2: Start n8n Docker Container

```bash
# Create data volume
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

**Verify:**
```bash
curl http://localhost:5678/healthz
# Expected: {"status":"ok"}
```

---

## Step 3: Install n8n-cli

```bash
# Install globally
npm install -g n8n-cli

# Verify installation
n8n --version
# Expected: n8n v1.9.1 or higher
```

---

## Step 4: Create n8n Admin Account

1. Open http://localhost:5678 in browser
2. Click "Create Account"
3. Fill in your details:
   - Email
   - First name
   - Last name
   - Password
4. Click "Create"

---

## Step 5: Generate API Key

1. Login to n8n at http://localhost:5678
2. Go to **Settings** (gear icon in top right)
3. Click **API Keys**
4. Click **Create API Key**
5. Name your key (e.g., "Terminal CLI")
6. Click **Create**
7. **Copy the API key** (starts with `eyJ...`)

---

## Step 6: Authenticate n8n-cli

```bash
# Login to n8n instance
n8n auth login -H http://localhost:5678 -k YOUR_API_KEY

# Replace YOUR_API_KEY with your actual API key from Step 5

# Verify authentication
n8n health
```

**Expected output:**
```
╭─ 🏥 n8n Health Check
│  Fetched: 2026-01-18 19:30:00 UTC
│  Host: http://localhost:5678
╰─

✅ Connection: OK
✅ API Key: Valid
ℹ️ Latency: 36ms
```

---

## Step 7: Configure Shell (Optional but Recommended)

```bash
# Add shell configuration
cat >> ~/.bashrc << 'EOF'

# n8n Terminal Environment
source ~/Desktop/Notes/n8n-documentations/shell-config.sh
EOF

# Reload shell
source ~/.bashrc
```

**Test shell configuration:**
```bash
n8n-health
n8n-list
```

---

## Step 8: Test Setup

Run the startup script to verify everything works:

```bash
cd ~/Desktop/Notes/n8n-documentations
./start-n8n.sh
```

**Expected output:**
```
🚀 Starting n8n Terminal Environment
======================================

📦 Checking Docker installation...
✅ Docker found: Docker version 28.3.2

🔄 Checking Docker daemon...
✅ Docker daemon is running

📦 Starting n8n Docker container...
✅ n8n container already running

⏳ Waiting for n8n to be ready...
✅ n8n is ready

🔧 Checking n8n-cli installation...
✅ n8n-cli found: n8n v1.9.1

🔑 Checking n8n authentication...
✅ Already authenticated with n8n

🏥 n8n Health Check:
╭─ 🏥 n8n Health Check
...
✅ Connection: OK

📋 Current Workflows:
...
```

---

## Step 9: Create Your First Workflow

```bash
# Use a template
n8n-use-template simple-schedule.json

# Create workflow
n8n workflows create --file simple-schedule.json

# Activate workflow (replace ID with actual ID)
n8n workflows activate --ids <WORKFLOW_ID> --force
```

---

## Quick Reference

### Daily Commands

```bash
# Start everything
n8n-startup

# List workflows
n8n workflows list

# Create workflow
n8n workflows create --file workflow.json

# Activate workflow
n8n workflows activate --ids <ID> --force
```

### File Locations

- **Documentation:** ~/Desktop/Notes/n8n-documentations/
- **Templates:** ~/Desktop/Notes/n8n-documentations/workflow-templates/
- **Startup:** ~/Desktop/Notes/n8n-documentations/start-n8n.sh
- **Config:** ~/.n8nrc.json

---

## Troubleshooting

### Docker Issues

**Problem:** Docker not found
```bash
# Reinstall Docker (macOS)
brew reinstall --cask docker

# Start Docker Desktop
open -a Docker
```

**Problem:** Container won't start
```bash
# Check logs
docker logs n8n

# Remove and recreate
docker rm -f n8n
# Run Step 2 commands again
```

### n8n-cli Issues

**Problem:** Command not found
```bash
# Reinstall n8n-cli
npm install -g n8n-cli

# Check installation
which n8n
```

**Problem:** Unauthorized error
```bash
# Re-authenticate
n8n auth login -H http://localhost:5678 -k YOUR_API_KEY

# Verify
n8n health
```

---

## Next Steps

After completing setup:

1. ✅ Read [README.md](README.md) for comprehensive documentation
2. ✅ Use [QUICK_START.md](QUICK_START.md) for daily reference
3. ✅ Explore [workflow templates](workflow-templates/) for ready-to-use workflows
4. ✅ Configure shell aliases for quick access
5. ✅ Set up auto-start on computer boot (see README.md)

---

## Support

Need help?
- Check [QUICK_START.md](QUICK_START.md) for quick reference
- Read [README.md](README.md) for detailed documentation
- Visit [n8n Community](https://community.n8n.io)
- Check [n8n CLI GitHub](https://github.com/yigitkonur/n8n-cli/issues)

---

**Setup Complete!** 🎉

You now have a fully functional n8n terminal environment!
