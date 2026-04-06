#!/bin/bash

# Array items must be separated by SPACES
# Add any extensions you need into this
EXTENSIONS=(
    "streetsidesoftware.code-spell-checker"
    "cweijan.vscode-database-client2"
    "cweijan.dbclient-jdbc"
    "ms-azuretools.vscode-containers"
    "ms-azuretools.vscode-docker"
    "dsznajder.es7-react-js-snippets"
    "github.vscode-github-actions"
    "golang.go"
    "ecmel.vscode-html-css"
    "xabikos.javascriptsnippets"
    "ms-vscode.vscode-typescript-next"
    "zainchen.json"
    "pkief.material-icon-theme"
    "chris-noring.node-snippets"
    "christian-kohler.npm-intellisense"
    "esbenp.prettier-vscode"
    "mechatroner.rainbow-csv"
    "bradlc.vscode-tailwindcss"
    "rangav.vscode-thunder-client"
    "redhat.vscode-xml"
    "redhat.vscode-yaml"
)

echo "🚀 Starting extension installation for code-server..."

for EXT in "${EXTENSIONS[@]}"; do
    echo "--------------------------------------------"
    echo "📦 Installing: $EXT"
    
    # We use --force to ensure it overwrites if a partial install existed
    code-server --install-extension "$EXT" --force
    
    if [ $? -eq 0 ]; then
        echo "✅ Successfully installed $EXT"
    else
        echo "❌ Failed to install $EXT"
    fi
done

echo "--------------------------------------------"
echo "🎉 All done! Restart code-server to see changes."