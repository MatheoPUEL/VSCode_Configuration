#!/usr/bin/env bash
set -e

echo "Vérification / Installation de JetBrains Mono Nerd Font pour VS Code..."
# --- Détection OS ---
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "macOS détecté"

  # Vérifie Homebrew
  if ! command -v brew &> /dev/null; then
    echo "Homebrew non détecté, installation"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  echo "Installation / vérification de JetBrainsMono Nerd Font..."
  brew install --cask font-jetbrains-mono-nerd-font

elif [[ "$OS" == "Windows_NT" ]]; then
  echo "Windows détecté"

  # Vérifie Chocolatey
  if ! command -v choco &> /dev/null; then
    echo "Chocolatey non détecté, installation"
    powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; \
      [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12; \
      iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
  fi

  echo "Installation / vérification de la Nerd Font..."
  choco install nerd-fonts-jetbrainsmono -y

else
  echo "OS non supporté automatiquement"
  exit 1
fi

echo "JetBrains Mono Nerd Font installée avec succès"

# --- Vérification du fichier settings.json ---
SETTINGS_PATH=""

if [[ "$OSTYPE" == "darwin"* ]]; then
  SETTINGS_PATH="$HOME/Library/Application Support/Code/User/settings.json"
elif [[ "$OS" == "Windows_NT" ]]; then
  SETTINGS_PATH="$APPDATA\\Code\\User\\settings.json"
fi

if [[ -f "$SETTINGS_PATH" ]]; then
  echo "Vérification de la config VS Code"
  if grep -q "JetBrainsMono Nerd Font" "$SETTINGS_PATH"; then
    echo "Font déjà configurée dans VS Code"
  else
    echo "Ajout automatique de la config de font"
    tmp=$(mktemp)
    jq '. + {"editor.fontFamily": "\"JetBrainsMono Nerd Font\", \"JetBrains Mono\", monospace", "editor.fontLigatures": true}' "$SETTINGS_PATH" > "$tmp" && mv "$tmp" "$SETTINGS_PATH"
  fi
else
  echo "settings.json introuvable, VS Code n’a peut-être pas encore été lancé une première fois."
fi

echo "Tout est prêt ! Redémarre VS Code"
