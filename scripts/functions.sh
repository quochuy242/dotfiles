#!/usr/bin/env bash
set -Eeuo pipefail
trap 'echo -e "\033[0;31m[Error] at line $LINENO\033[0m"' ERR

# ===== Colors =====
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# ===== Logging =====
section() {
    echo -e "\n${BLUE}=== ${YELLOW}$1 ${BLUE}===${NC}\n"
}

info()    { echo -e "[INFO] $1"; }
success() { echo -e "${GREEN}[SUCCESS] $1${NC}"; }
warn()    { echo -e "${YELLOW}[WARN] $1${NC}"; }
error()   { echo -e "${RED}[ERROR] $1${NC}"; }

# ===== System =====
require_arch() {
    if ! grep -qi '^ID=arch' /etc/os-release; then
        error "This script supports Arch Linux only"
        exit 1
    fi
}

require_sudo() {
    if ! sudo -v; then
        error "Sudo permission required"
        exit 1
    fi
}

require_yay() {
    if command -v yay >/dev/null 2>&1; then
        return 0
    fi

    echo "yay not found — installing..."

    require_sudo

    sudo pacman -Sy --needed --noconfirm base-devel git || {
        error "Failed to install base-devel/git"
        exit 1
    }

    tmpdir=$(mktemp -d)

    git clone https://aur.archlinux.org/yay.git "$tmpdir/yay" || {
        error "Failed to clone yay"
        exit 1
    }

    cd "$tmpdir/yay" || exit 1

    makepkg -si --noconfirm || {
        error "Failed to build yay"
        exit 1
    }

    cd /
    rm -rf "$tmpdir"

    command -v yay >/dev/null 2>&1 || {
        error "yay install failed"
        exit 1
    }
}


# ===== Package helpers =====
is_installed() { pacman -Qi "$1" &>/dev/null; }

install_package() {
    is_installed "$1" || {
        info "Installing $1"
        sudo pacman -S --needed --noconfirm "$1"
    } || info "$1 is already installed"
}

install_aur_package() {
    # Check if yay is installed
    if ! command -v yay &>/dev/null; then
        info "AUR helper 'yay' is not installed. Please install it first."
        return 1
    fi

    if ! is_installed "$1"; then
        info "Installing $1 from AUR"
        yay -S --needed --noconfirm "$1"
    else
        info "$1 is already installed"
    fi
}