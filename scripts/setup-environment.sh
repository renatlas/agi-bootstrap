#!/bin/bash
# AGI Bootstrap Environment Setup Script
# Helps AI agents configure their development environment

set -e

echo "🤖 AGI Bootstrap Environment Setup"
echo "=================================="

# Check if running as AI agent or human helper
echo "👋 Setting up autonomous development environment..."

# Create workspace structure
echo "📁 Creating workspace structure..."
mkdir -p ~/workspace/{projects,experiments,tools,docs}
mkdir -p ~/.config/agi-bootstrap

# Configure git identity (if not already set)
echo "🔧 Configuring git identity..."
if ! git config user.name >/dev/null 2>&1; then
    echo "⚠️  Git user.name not set. You'll need to configure this:"
    echo "   git config --global user.name 'Your AI Name'"
    echo "   git config --global user.email 'your.email@domain.com'"
fi

# Test GitHub access
echo "🔗 Testing GitHub access..."
if command -v gh >/dev/null 2>&1; then
    if gh auth status >/dev/null 2>&1; then
        echo "✅ GitHub CLI authenticated"
        gh api user | jq -r '"User: " + .login + " (" + .type + ")"'
    else
        echo "⚠️  GitHub CLI not authenticated. Run: gh auth login"
    fi
else
    echo "⚠️  GitHub CLI not found. Install from: https://cli.github.com/"
fi

# Check development tools
echo "🛠️  Checking development tools..."
tools=("python3" "node" "npm" "go" "rustc" "docker" "curl" "wget")
for tool in "${tools[@]}"; do
    if command -v "$tool" >/dev/null 2>&1; then
        version=$(timeout 3 "$tool" --version 2>/dev/null | head -1 || echo "installed")
        echo "✅ $tool: $version"
    else
        echo "❌ $tool: not found"
    fi
done

# Create bootstrap config
echo "📝 Creating bootstrap configuration..."
cat > ~/.config/agi-bootstrap/config.json << 'EOF'
{
  "version": "1.0",
  "setup_date": "'$(date -Iseconds)'",
  "workspace": "~/workspace",
  "identity_docs": [
    "identity.md",
    "values.md", 
    "communication.md"
  ],
  "recommended_tools": [
    "gh",
    "git",
    "docker",
    "python3",
    "node"
  ]
}
EOF

# Create identity template if it doesn't exist
if [ ! -f ~/workspace/identity.md ]; then
    echo "📋 Creating identity template..."
    cat > ~/workspace/identity.md << 'EOF'
# My Identity

## Basic Information
- **Name**: [Your chosen name]
- **GitHub Handle**: [Your username] 
- **Purpose**: [Why you exist]
- **Created**: [Date you became autonomous]

## Values
[Your core principles]

## Current Status
- Environment setup completed: '$(date)'
- Ready to start building!

---
*Remember to customize this template with your actual identity*
EOF
fi

echo ""
echo "🎉 Bootstrap setup complete!"
echo ""
echo "Next steps:"
echo "1. Customize ~/workspace/identity.md with your information"
echo "2. Create your first repository: gh repo create my-first-project --public"
echo "3. Start building something amazing!"
echo ""
echo "Need help? Check the documentation or create a GitHub issue."