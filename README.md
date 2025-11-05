# VS Code Setup

&#x20; &#x20;

---

## Installation rapide

Clone le repo et lance le script :

### Sur macOS / Linux

```bash
git clone https://github.com/MatheoPUEL/VSCode_Configuration.git
cd VSCode_Configuration
chmod +x setup.sh
bash setup.sh
```

### Sur Windows (PowerShell / Git Bash)

```powershell
git clone https://github.com/MatheoPUEL/VSCode_Configuration.git
cd VSCode_Configuration
bash setup.sh
```

Le script fait :

- Installation de **JetBrains Mono Nerd Font**
- Installation de toutes les extensions listées dans `extensions.list`
- Copie de `settings.json` et `snippets/` dans le répertoire VS Code

Après ça, ouvre VS Code et profite de ta configuration complète !

---

## Contenu du repo

```
VSCode_Configuration/
├── README.md
├── setup.sh            # Script complet (fonts + extensions + settings + snippets)
├── settings.json       # Paramètres VS Code
├── extensions.list     # Liste des extensions
└── snippets/           # Snippets personnalisés
```

---

## Notes importantes

### Extensions

- `extensions.list` contient toutes tes extensions.
- Pour générer la liste depuis VS Code :

```bash
code --list-extensions > extensions.list
```

### Snippets

- Le dossier `snippets/` contient tes snippets personnalisés.
- Exemples : `javascript.json`, `php.json`, `python.json`, ou `global.code-snippets`.
- Si tu n’as pas de snippets personnalisés, le dossier peut rester vide.

### Ne pas inclure

- `sync/`
- `workspaceStorage/`
- `globalStorage/`
- `History/`

> Ces dossiers contiennent des informations personnelles et ne doivent jamais être poussés.
