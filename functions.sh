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
require_fedora() {
    [[ -f /etc/fedora-release ]] || {
        error "This script supports Fedora only"
        exit 1
    }
}

require_sudo() {
    sudo -v || {
        error "Sudo permission required"
        exit 1
    }
}

# ===== Package helpers =====
is_installed() {
    rpm -q "$1" &>/dev/null
}

install_pkg() {
    local pkg="$1"
    if is_installed "$pkg"; then
        success "$pkg already installed"
    else
        info "Installing $pkg"
        sudo dnf install -y "$pkg"
        success "$pkg installed"
    fi
}

install_pkgs() {
    for pkg in "$@"; do
        install_pkg "$pkg"
    done
}