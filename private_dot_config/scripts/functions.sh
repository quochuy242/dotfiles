
#!/bin/bash
set -e  # Exit on error

# Set up colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Config repo URL
REPO_URL="https://github.com/quochuy242/dotfiles.git"
CLONE_DIR="$HOME/dotfiles"
SCRIPTS_DIR="$CLONE_DIR/scripts"

# Function for printing section headers
print_section() {
  echo -e "\n${BLUE}===${NC} ${YELLOW}$1 ${BLUE}=== ${NC}\n"
}
print_subsection() {
  echo -e "\n ${GREEN}$1 ${NC}\n"
}
print_info() {
  echo -e "$1 \n"
}
print_error() {
  echo -e "${RED}$1${NC} \n"
}

print_success() {
  echo -e "${GREEN}$1${NC} \n"
}

is_installed() { pacman -Qi "$1" &>/dev/null; }

install_package() {
  is_installed "$1" || {
    print_info "Installing $1"
    sudo pacman -S --needed --noconfirm "$1"
  } || print_info "$1 is already installed"
}

install_aur_package() {
  # Check if yay is installed
  if ! command -v yay &>/dev/null; then
    print_info "AUR helper 'yay' is not installed. Please install it first."
    return 1
  fi

  if ! is_installed "$1"; then
    print_info "Installing $1 from AUR"
    yay -S --needed --noconfirm "$1"
  else
    print_info "$1 is already installed"
  fi
}

