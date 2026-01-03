#!/bin/bash
DOTFILES_DIR=$(pwd)
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$HOME/.bkp_configs/$TIMESTAMP"
echo "Starting setup..."
# Function to backup and symlink
safe_link() {
    local src=$1
    local dest=$2
    if [ -f "$dest" ] || [ -L "$dest" ] || [ -d "$dest" ]; then
        if [ ! -d "$BACKUP_DIR" ]; then
            echo "Creating backup directory at $BACKUP_DIR"
            mkdir -p "$BACKUP_DIR"
        fi
        echo "Backing up $dest to $BACKUP_DIR"
        mv "$dest" "$BACKUP_DIR/"
    fi
    ln -sf "$src" "$dest"
}

# 1. Ensure Neovim config directory exists
mkdir -p ~/.config/nvim

echo "Creating symlinks and backing up old configs..."
safe_link "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
safe_link "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
safe_link "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
safe_link "$DOTFILES_DIR/vimrc.vim" "$HOME/.vimrc"
safe_link "$DOTFILES_DIR/init.lua" "$HOME/.config/nvim/init.lua"
safe_link "$DOTFILES_DIR/vimrc.vim" "$HOME/.config/nvim/vimrc.vim"

# 3. Bootstrap vim-plug for Neovim if not present
#if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
#    echo "Installing vim-plug for Neovim..."
#    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
#       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#fi
echo "-----------------------------------------------"
echo "Setup complete!"
if [ -d "$BACKUP_DIR" ]; then
    echo "Your old configurations were moved to: $BACKUP_DIR"
fi
echo "Next steps: Open nvim and run :PlugInstall"
