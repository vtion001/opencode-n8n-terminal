#!/bin/bash

# Complete n8n environment startup script
# Usage: ./start-n8n.sh

set -e

echo "🚀 Starting n8n Terminal Environment"
echo "======================================"
echo ""

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# 1. Check Docker
echo "📦 Checking Docker installation..."
if ! command_exists docker; then
    echo "❌ Docker not found. Please install Docker first."
    echo "   macOS: brew install --cask docker"
    echo "   Linux: curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh"
    exit 1
fi
echo "✅ Docker found: $(docker --version)"
echo ""

# 2. Check Docker daemon
echo "🔄 Checking Docker daemon..."
if ! docker info >/dev/null 2>&1; then
    echo "❌ Docker daemon not running. Please start Docker Desktop or Docker service."
    exit 1
fi
echo "✅ Docker daemon is running"
echo ""

# 3. Start n8n Docker container
echo "📦 Starting n8n Docker container..."
if docker ps | grep -q "n8n"; then
    echo "✅ n8n container already running"
else
    # Check if container exists but stopped
    if docker ps -a | grep -q "n8n"; then
        echo "🔄 Starting existing n8n container..."
        docker start n8n
    else
        echo "📦 Creating and starting new n8n container..."
        
        # Check if volume exists
        if ! docker volume ls | grep -q "n8n_data"; then
            echo "📦 Creating n8n data volume..."
            docker volume create n8n_data
        fi
        
        # Run container
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
        
        echo "✅ n8n container started"
    fi
fi
echo ""

# 4. Wait for n8n to be ready
echo "⏳ Waiting for n8n to be ready..."
MAX_WAIT=30
WAIT_COUNT=0
until curl -s http://localhost:5678/healthz > /dev/null 2>&1; do
    echo -n "."
    WAIT_COUNT=$((WAIT_COUNT + 1))
    if [ $WAIT_COUNT -ge $MAX_WAIT ]; then
        echo ""
        echo "❌ Timeout waiting for n8n to be ready"
        echo "   Check logs: docker logs n8n"
        exit 1
    fi
    sleep 1
done
echo ""
echo "✅ n8n is ready"
echo ""

# 5. Check n8n-cli installation
echo "🔧 Checking n8n-cli installation..."
if ! command_exists n8n; then
    echo "⚠️  n8n-cli not found. Installing..."
    npm install -g n8n-cli
    echo "✅ n8n-cli installed"
else
    echo "✅ n8n-cli found: $(n8n --version)"
fi
echo ""

# 6. Check n8n authentication
echo "🔑 Checking n8n authentication..."
if n8n health >/dev/null 2>&1; then
    echo "✅ Already authenticated with n8n"
else
    echo "⚠️  Not authenticated with n8n"
    echo ""
    echo "Please authenticate:"
    echo "  1. Open http://localhost:5678 in your browser"
    echo "  2. Create your admin account (first time)"
    echo "  3. Go to Settings → API Keys → Create API Key"
    echo "  4. Run: n8n auth login -H http://localhost:5678 -k YOUR_API_KEY"
    echo ""
    read -p "Press Enter once you've authenticated, or Ctrl+C to exit..."
    if ! n8n health >/dev/null 2>&1; then
        echo "❌ Still not authenticated. Exiting."
        exit 1
    fi
fi
echo ""

# 7. Run health check
echo "🏥 n8n Health Check:"
n8n health
echo ""

# 8. List current workflows
echo "📋 Current Workflows:"
n8n workflows list
echo ""

# 9. Summary
echo "======================================"
echo "✅ n8n environment ready!"
echo ""
echo "🔗 n8n URL:      http://localhost:5678"
echo "📖 Documentation:  ~/Desktop/Notes/n8n-documentations"
echo ""
echo "Quick Commands:"
echo "  n8n workflows list              # List all workflows"
echo "  n8n workflows create --file X   # Create workflow"
echo "  n8n workflows activate --ids X  # Activate workflow"
echo "  n8n executions list             # View executions"
echo "  n8n health                     # Check health"
echo ""
