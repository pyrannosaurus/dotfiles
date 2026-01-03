# Dotfiles

A portable configuration for Neovim (v0.11+), Vim, Tmux, and Zsh/Bash.

## Structure
- `init.lua`: Neovim entry point (LSP, Treesitter).
- `vimrc.vim`: Shared Vim/Neovim settings (Plugins, Keybinds).
- `.tmux.conf`: Terminal multiplexer config.
- `.zshrc` / `.bashrc`: Shell configurations.

## Installation

1. **Clone the repo:**
   git clone <your-repo-url> ~/dotfiles
   cd ~/dotfiles

2. **Run the setup script:**
   chmod +x install.sh
   ./install.sh

3. **Install Plugins:**
   Open nvim and run:
   - :PlugInstall
   - :TSUpdate

## Backups
The install.sh script is non-destructive. If it detects existing configuration files, it will move them to a timestamped backup folder in your home directory (e.g., ~/.bkp_configs/20260102_123005) before creating the new symlinks.

## Dependencies
This config expects the following tools to be installed on your system:

| Tool | Purpose | Install Command (MacOS) |
| :--- | :--- | :--- |
| Pyright | Python LSP | npm install -g pyright |
| Prettier | JS/TS Formatter | npm install -g prettier |
| Sqlfluff | SQL Formatter | pip install sqlfluff |
| Node.js | Required for LSPs | brew install node |

## Note on Tmux
Platform-specific tmux configs (.tmux.linux.conf, .tmux.mac.conf) are stored here but are not symlinked automatically. Reference them within your main .tmux.conf based on your OS.
The .tmux.conf does make an assumption that .tmux.mac.conf is in ~/dotfiles and that a private tmux file is located in ~/.  Adjust accordingly.
