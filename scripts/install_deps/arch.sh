#!/bin/bash
set -e # Exit on error

# Import the common functions
SRC_DIR="$(pwd)"
source "$SRC_DIR/common.sh"

# Function to check if a package is installed
is_installed() {
  pacman -Qi "$1" &>/dev/null
}

# Create some directories if it doesn't exist
mkdir -p ~/.local/bin ~/.cargo/env

print_section "Updating system"
sudo pacman -Syu --noconfirm

print_section "Installing dependencies"
sudo pacman -S --needed --noconfirm git base-devel

# Check if yay is already installed
# if ! command -v yay &>/dev/null; then
#   print_section "Installing yay AUR helper"
#   git clone https://aur.archlinux.org/yay.git $HOME/yay
#   cd $HOME/yay
#   makepkg -si --noconfirm
#   cd ~
# else
#   print_section "yay is already installed"
# fi

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
sudo pacman -S --needed --noconfirm yazi superfile

print_section "Installing terminal emulators"
sudo pacman -S --needed --noconfirm kitty alacritty

print_section "Installing shell enhancements"
sudo pacman -S --needed --noconfirm atuin starship

print_section "Setup tmux"
print_subsection "Install sesh - tmux session manager"
# yay -S sesh-bin gitmux
# sudo pacman -S --needed --noconfirm github-cli
# gh auth login # Login GitHub before installing extension
# gh extension install dlvhdr/gh-dash

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
  cd $HOME/dotfiles
  stow .
else
  print_section "No .stowrc found, skipping stow"
fi

# Setup zsh
print_section "Setting up zsh"
touch ~/.zshrc
if ! grep -qxF "source \$HOME/dotfiles/zsh/main.zsh" ~/.zshrc; then
  echo "source \$HOME/dotfiles/zsh/main.zsh" >>~/.zshrc
fi

print_section "Installation complete!"
echo -e "${GREEN}All packages and tools have been installed.${NC}"
echo -e "You may need to log out and back in for all changes to take effect."
echo -e "To apply Tmux plugins, press prefix + I inside tmux."
