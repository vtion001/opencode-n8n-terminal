# n8n Terminal Environment Configuration
# Add to ~/.bashrc or ~/.zshrc

# n8n environment variables
export N8N_HOST="http://localhost:5678"

# n8n aliases for quick workflow management
alias n8n-list="n8n workflows list"
alias n8n-create="n8n workflows create --file"
alias n8n-activate="n8n workflows activate --ids"
alias n8n-deactivate="n8n workflows deactivate --ids"
alias n8n-get="n8n workflows get"
alias n8n-delete="n8n workflows delete --ids"
alias n8n-health="n8n health"
alias n8n-exec="n8n executions list"
alias n8n-validate="n8n workflows validate"
alias n8n-autofix="n8n workflows autofix"

# n8n Docker aliases
alias n8n-start="docker start n8n"
alias n8n-stop="docker stop n8n"
alias n8n-restart="docker restart n8n"
alias n8n-logs="docker logs n8n"
alias n8n-status="docker ps | grep n8n"

# n8n quick access
alias n8n-docs="cd ~/Desktop/Notes/n8n-documentations"
alias n8n-startup="~/Desktop/Notes/n8n-documentations/start-n8n.sh"
alias n8n-templates="cd ~/Desktop/Notes/n8n-documentations/workflow-templates"

# Function to quickly create and activate workflow
n8n-quick-create() {
    local workflow_file="$1"
    if [ -z "$workflow_file" ]; then
        echo "Usage: n8n-quick-create <workflow-file.json>"
        return 1
    fi
    
    echo "Creating workflow from $workflow_file..."
    n8n workflows create --file "$workflow_file"
    
    if [ $? -eq 0 ]; then
        echo "✅ Workflow created successfully!"
        echo "Activate it with: n8n-activate <WORKFLOW_ID> --force"
    fi
}

# Function to list workflow templates
n8n-templates-list() {
    echo "Available workflow templates:"
    ls -1 ~/Desktop/Notes/n8n-documentations/workflow-templates/
}

# Function to use workflow template
n8n-use-template() {
    local template_name="$1"
    local output_name="${2:-my-workflow.json}"
    
    if [ -z "$template_name" ]; then
        echo "Usage: n8n-use-template <template-name> [output-file]"
        echo ""
        n8n-templates-list
        return 1
    fi
    
    local template_path="~/Desktop/Notes/n8n-documentations/workflow-templates/$template_name"
    
    if [ ! -f "$template_path" ]; then
        echo "❌ Template not found: $template_name"
        return 1
    fi
    
    cp "$template_path" "$output_name"
    echo "✅ Template copied to: $output_name"
    echo "Edit it and create with: n8n workflows create --file $output_name"
}
