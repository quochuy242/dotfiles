#!/bin/bash
set -e  # Exit on error

# Set up colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function for printing section headers
print_section() {
    echo -e "\n${BLUE}===${NC} ${GREEN}$1 ${NC}===\n"
}

# Go Home
cd ~

# Create local bin directory if it doesn't exist
mkdir -p ~/.local/bin

print_section "Updating system and installing Homebrew"
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    brew update
    brew upgrade
fi

# Install packages
print_section "Installing dependencies"
brew install git stow

print_section "Installing shell environments"
brew install zsh

print_section "Installing modern CLI utilities"
brew install zoxide eza fd fzf bat ripgrep

print_section "Installing system monitoring tools"
brew install htop btop fastfetch

print_section "Installing text editors and terminal multiplexers"
brew install nano vim neovim tmux

print_section "Installing file managers"
brew install yazi

print_section "Installing terminal emulators"
brew install kitty alacritty

print_section "Installing shell enhancements"
brew install atuin starship

# Install TPM if not already installed
if [ ! -d "$HOME/.config/tmux/plugins/tpm" ]; then
    print_section "Installing Tmux Plugin Manager"
    mkdir -p ~/.config/tmux/plugins/tpm 
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
else
    print_section "Tmux Plugin Manager is already installed"
fi

# Setup bat cache
print_section "Building bat cache"
bat cache --build || true  # Ignore errors if bat cache isn't needed

# Check if stow target exists
print_section "Setting up dotfiles with stow"
if [ -f ".stowrc" ]; then
    print_section "Running stow"
    stow .
else
    print_section "No .stowrc found, skipping stow"
fi

# Setup zsh
print_section "Setting up zsh"
touch ~/.zshrc
if ! grep -qxF "source \$HOME/dotfiles/zsh/main.zsh" ~/.zshrc; then
    echo "source \$HOME/dotfiles/zsh/main.zsh" >> ~/.zshrc
fi

print_section "Installation complete!"
echo -e "${GREEN}All packages and tools have been installed.${NC}"
echo -e "You may need to restart your terminal for all changes to take effect."
echo -e "To apply Tmux plugins, press prefix + I inside tmux."
