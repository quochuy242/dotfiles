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

# Go Home
cd ~
mkdir -p ~/.local/bin

print_section "Updating system"
sudo apt update && sudo apt upgrade -y

print_section "Installing dependencies"
sudo apt install -y git build-essential

print_section "Installing shell environments"
sudo apt install -y zsh

print_section "Installing configuration tools"
sudo apt install -y stow

print_section "Installing modern CLI utilities"

# Install zoxide
if ! command -v zoxide &> /dev/null; then
    print_section "Installing zoxide"
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
else
    print_section "zoxide is already installed"
fi

# Install eza (not in default repos, using cargo)
if ! command -v eza &> /dev/null; then
    print_section "Installing eza"
    if ! command -v cargo &> /dev/null; then
        sudo apt install -y cargo
    fi
    cargo install eza
else
    print_section "eza is already installed"
fi

# Install other CLI utilities
sudo apt install -y fd-find fzf bat ripgrep

# Create symbolic links
ln -sf "$(command -v fdfind)" ~/.local/bin/fd 2>/dev/null || true
ln -sf "$(command -v batcat)" ~/.local/bin/bat 2>/dev/null || true

print_section "Installing system monitoring tools"
sudo apt install -y htop

# Install btop
if ! command -v btop &> /dev/null; then
    if apt-cache show btop &> /dev/null; then
        sudo apt install -y btop
    else
        sudo add-apt-repository -y ppa:ubuntuhandbook1/apps
        sudo apt update
        sudo apt install -y btop
    fi
fi

# Install fastfetch
if ! command -v fastfetch &> /dev/null; then
    print_section "Installing fastfetch"
    sudo add-apt-repository ppa:zhangsongcui3371/fastfetch -y
    sudo apt update
    sudo apt install -y fastfetch
else
    print_section "fastfetch is already installed"
fi

print_section "Installing text editors and terminal multiplexers"
sudo apt install -y nano vim tmux

# Neovim from PPA
sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim

print_section "Installing file managers"
bash -c "$(curl -sLo- https://superfile.netlify.app/install.sh)"

print_section "Installing terminal emulators"
sudo apt install -y kitty

if ! command -v alacritty &> /dev/null; then
    sudo add-apt-repository -y ppa:aslatter/ppa
    sudo apt update
    sudo apt install -y alacritty
fi

print_section "Installing shell enhancements"

# Install atuin
if ! command -v atuin &> /dev/null; then
    print_section "Installing atuin"
    bash <(curl https://raw.githubusercontent.com/atuinsh/atuin/main/install.sh)
else
    print_section "atuin is already installed"
fi

# Install starship
if ! command -v starship &> /dev/null; then
    print_section "Installing starship"
    curl -sS https://starship.rs/install.sh | sh
else
    print_section "starship is already installed"
fi

# Install TPM
if [ ! -d "$HOME/.config/tmux/plugins/tpm" ]; then
    print_section "Installing Tmux Plugin Manager"
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
else
    print_section "Tmux Plugin Manager is already installed"
fi

# Build bat cache
print_section "Building bat cache"
if command -v bat &> /dev/null; then
    bat cache --build
elif command -v batcat &> /dev/null; then
    batcat cache --build
fi

# Setup dotfiles
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
    echo "source \$HOME/dotfiles/zsh/main.zsh" >> ~/.zshrc
fi

print_section "Installation complete!"
echo -e "${GREEN}All packages and tools have been installed.${NC}"
echo -e "You may need to log out and back in for all changes to take effect."
echo -e "To apply Tmux plugins, press prefix + I inside tmux."
