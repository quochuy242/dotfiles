#!/usr/bin/env bash
source "$(dirname "$0")/functions.sh"

enable_rpmfusion() {
    section "Enable RPM Fusion"
    
    if rpm -q rpmfusion-free-release &>/dev/null; then
        success "RPM Fusion already enabled"
        return
    fi
    
    sudo dnf install -y \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    
    success "RPM Fusion enabled"
}

install_core() {
    section "Core packages"
    
    install_pkgs \
    git \
    curl \
    wget \
    neovim \
    tmux \
    zsh \
    fzf \
    ripgrep \
    btop
}

install_cli() {
    section "CLI packages"

    sudo dnf copr enable lihaohong/yazi
    sudo dnf copr enable dejan/lazygit

    curl -sS https://starship.rs/install.sh | sh

    install_pkgs \
    bat \
    eza\
    fd-find \
    zoxide \
    yazi \
    lazygit
}

install_python() {    
    section "Python packages"
    
    install_pkgs \
    pipx \
    python3.13-pip \
    python3 \
    uv

    pipx ensurepath
}

install_tmux() {
    section "Tmux plugins"
    
    if [ ! -d "$HOME/.config/tmux/plugins/tpm" ]; then
        info "Installing Tmux Plugin Manager"
        mkdir -p ~/.config/tmux/plugins/tpm
        git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
    else
        info "Tmux Plugin Manager is already installed"
    fi
}

install_atuin() {
    section "Atuin"
    install_pkg atuin
}

install_cpp() {
    section "C++"
    install_pkg clang base-devel gcc
}

install_lua() {
    section "Lua"
    install_pkg lua luarocks
}

main() {
    enable_rpmfusion
    install_core
    install_python
    install_tmux
    install_atuin
    install_cpp
    install_lua
}

main "$@"