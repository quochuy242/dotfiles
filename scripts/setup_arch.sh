#!/bin/bash
set -e  # Exit on error

# Set up colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function for printing
print_section() {
    echo -e "\n${BLUE}===${NC} ${YELLOW}$1 ${BLUE}===\n"
}
print_info() {
    echo -e "${NC} ${GREEN}$1${NC}\n"
}
print_subsection() {
    echo -e "\n ${YELLOW}$1 ${NC}\n"
}


# Function to check if a package is installed
is_installed() {
    pacman -Qi "$1" &> /dev/null
}

# Go Home
cd ~

# Create local bin directory if it doesn't exist
mkdir -p ~/.local/bin

print_section "Updating system"
sudo pacman -Syu --noconfirm

print_section "Installing dependencies"
sudo pacman -S --needed --noconfirm git base-devel

# Check if paru is already installed
if ! command -v paru &> /dev/null; then
    print_section "Installing paru AUR helper"
    git clone https://aur.archlinux.org/paru.git $HOME/paru
    cd $HOME/paru
    makepkg -si --noconfirm
    cd ~
else
    print_section "paru is already installed"
fi

# Install packages
print_section "Installing shell environments"
sudo pacman -S --needed --noconfirm zsh

print_section "Installing configuration tools"
sudo pacman -S --needed --noconfirm stow

print_section "Installing modern CLI utilities"
sudo pacman -S --needed --noconfirm zoxide eza fd fzf bat ripgrep

print_section "Installing system monitoring tools"
sudo pacman -S --needed --noconfirm htop btop fastfetch

print_section "Installing text editors and terminal multiplexers"
sudo pacman -S --needed --noconfirm nano vim neovim tmux

print_section "Installing file managers"
sudo pacman -S --needed --noconfirm yazi

print_section "Installing terminal emulators"
sudo pacman -S --needed --noconfirm kitty alacritty

print_section "Installing shell enhancements"
sudo pacman -S --needed --noconfirm atuin starship

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
bat cache --build

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
echo -e "You may need to log out and back in for all changes to take effect."
echo -e "To apply Tmux plugins, press prefix + I inside tmux."