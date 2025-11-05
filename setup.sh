#!/usr/bin/env bash
set -e

echo "Setup complet VS Code — Font, Extensions, Settings"

# Détection OS et chemins VS Code
OS_NAME=$(uname -s)
if [[ "$OS_NAME" == "Darwin" ]]; then
    OS="macOS"
    VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
elif [[ "$OS_NAME" == "Linux" ]]; then
    OS="Linux"
    VSCODE_USER_DIR="$HOME/.config/Code/User"
elif [[ "$OS_NAME" == "MINGW"* || "$OS_NAME" == "CYGWIN"* ]]; then
    OS="Windows"
    VSCODE_USER_DIR="$APPDATA\\Code\\User"
else
    echo "OS non supporté : $OS_NAME"
    exit 1
fi

echo "OS détecté : $OS"
echo "Répertoire VS Code : $VSCODE_USER_DIR"

# --- Vérification que VS Code est installé ---
if ! command -v code &> /dev/null; then
    echo "VS Code n'est pas trouvé dans le PATH."
    echo "Installez VS Code avant de continuer."
    exit 1
fi

# --- Installation de la JetBrains Mono Nerd Font ---
echo "Installation de la JetBrains Mono Nerd Font"
if [[ "$OS" == "macOS" ]]; then
    if ! command -v brew &> /dev/null; then
        echo "Homebrew non trouvé, installation"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install --cask font-jetbrains-mono-nerd-font
elif [[ "$OS" == "Linux" ]]; then
    echo "Sur Linux, installez la font manuellement si nécessaire."
elif [[ "$OS" == "Windows" ]]; then
    if ! command -v choco &> /dev/null; then
        echo "📦 Chocolatey non trouvé, installation..."
        powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; \
          [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12; \
          iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
    fi
    choco install nerd-fonts-jetbrainsmono -y
fi

# --- Installer les extensions depuis extensions.list ---
if [[ -f "extensions.list" ]]; then
    echo "Installation des extensions VS Code"
    while IFS= read -r ext; do
        if ! code --list-extensions | grep -q "$ext"; then
            echo "➕ Installation : $ext"
            code --install-extension "$ext"
        else
            echo "Déjà installé : $ext"
        fi
    done < extensions.list
else
    echo "extensions.list non trouvé, aucune extension installée."
fi

# --- Copier settings.json et snippets ---
echo "Copie des fichiers de configuration VS Code..."

mkdir -p "$VSCODE_USER_DIR"

# settings.json
if [[ -f "settings.json" ]]; then
    cp settings.json "$VSCODE_USER_DIR/settings.json"
    echo "settings.json copié"
fi

# snippets/
if [[ -d "snippets" ]]; then
    cp -r snippets "$VSCODE_USER_DIR/"
    echo "snippets/ copiés"
fi

echo ""
echo "Setup complet"
echo ""
echo "Relancez VSCode !"
