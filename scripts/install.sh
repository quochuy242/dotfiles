#!/usr/bin/env bash
source "$(dirname "$0")/functions.sh"

require_arch

install_core() {
    section "Core packages"
    
    require_yay
    
    install_package git
    install_package curl
    install_package wget
    install_package neovim
    install_package tmux
    install_package zsh
    install_package fzf
    install_package ripgrep
    install_package btop
    install_package unzip
    install_package tar
    install_package gzip
    install_package rsync
}

install_ampcode() {
    section "Ampcode"
    curl -fsSL https://ampcode.com/install.sh | bash
    export PATH="$HOME/.local/bin:$PATH"

    info "Setting up Context7 API integration"
    
    read -p "Enter your Context7 API key (or press Enter to skip): " context7_api_key
    
    if [ -n "$context7_api_key" ]; then
        info "Adding Context7 API key to Ampcode config"
        amp mcp add context7 --header "CONTEXT7_API_KEY=$context7_api_key" https://mcp.context7.com/mcp
        success "Context7 API key added to Ampcode"
    else
        warn "Skipping Context7 API setup. You can add it later with:"
        warn "  amp mcp add context7 --header \"CONTEXT7_API_KEY=<your-key>\" https://mcp.context7.com/mcp"
    fi

}

install_cli() {
    section "CLI packages"

    curl -sS https://starship.rs/install.sh | sh
    
    install_package bat
    install_package eza
    install_package fd
    install_package zoxide
    install_aur_package yazi
    install_aur_package lazygit
}

install_python() {    
    section "Python packages"
    
    install_package python-pipx
    install_package python
    install_package uv

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
    install_package atuin
}

install_cpp() {
    section "C++"
    install_package clang
    install_package base-devel
    install_package gcc
}

install_lua() {
    section "Lua"
    install_package lua
    install_package luarocks
}

install_rust() {
    section "Rust"
    
    if ! command -v rustup &>/dev/null; then
        info "Installing Rustup"
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env"
        rustup default stable
    else
        success "Rustup is already installed"
    fi
    
    info "Setup component and tool for Rust"
    rustup component add rust-src
    rustup component add rust-analyzer
    rustup component add clippy
    rustup component add rustfmt
}

install_go() {
    section "Go"
    install_package go
}

install_java() {
    section "Java"
    install_package jdk-openjdk
    install_package maven
}

install_nodejs() {
    section "Node.js"
    install_package nodejs
    install_package npm
}

install_docker() {
    section "Docker"
    install_package docker
    install_package docker-compose
    
    info "Adding current user to docker group"
    sudo usermod -aG docker "$USER"
    success "Docker installed. You may need to log out and back in for group changes to take effect"
}

install_kubernetes() {
    section "Kubernetes"
    install_package kubectl
    install_aur_package minikube
}

install_containerd() {
    section "Containerd"
    install_aur_package nerdctl-full-bin
}

install_gui() {
    section "GUI packages"
    
    install_package xorg-server
    install_package xorg-xinit
    install_package xorg-xwayland
    install_package wayland
    install_package libxcb
    install_package xcb-util
}

install_desktop_env() {
    section "Hyprland Desktop Environment"
    
    install_package hyprland
    install_package hyprland-protocols
    install_package hyprpaper
    install_package hypridle
    install_package hyprlock
    install_package sddm
    install_package kitty
    install_package nemo
    install_package dunst
    install_package rofi
}

install_fonts() {
    section "Fonts"
    
    install_package noto-fonts
    install_package noto-fonts-cjk
    install_package noto-fonts-emoji
    install_package ttf-meslo-nerd
    install_package ttf-jetbrains-mono-nerd
    install_package ttf-iosevka-nerd
    install_package ttf-dejavu
    install_package ttf-liberation
}

install_input_method() {
    # Fcitx5
    section "Fcitx5 Input Method"
    
    install_package fcitx5-im
    install_package fcitx5-unikey

    success "Fcitx5 installed and configured"
    info "You can configure Fcitx5 with: fcitx5-configtool"
}

install_media() {
    section "Media packages"
    
    install_package ffmpeg
    install_package imagemagick
    install_package vlc
    install_package mpv
}

install_utils() {
    section "Utility packages"
    
    install_package keepass
    install_package firefox
    install_package transmission-gtk
    install_package flameshot
    install_aur_package visual-studio-code-bin
}

linux_desktop() {
    section "Setting up Linux Desktop Environment"
    
    install_core
    install_ampcode
    install_cli
    install_gui
    install_desktop_env
    install_fonts
    install_input_method
    install_media
    install_python
    install_tmux
    install_atuin
    install_cpp
    install_lua
    install_rust
    install_go
    install_java
    install_nodejs
    install_docker
    install_kubernetes
    install_containerd
    install_utils
    
    success "Linux Desktop setup complete!"
}

wsl() {
    section "Setting up WSL Environment"
    
    install_core
    install_ampcode
    install_cli
    install_python
    install_tmux
    install_atuin
    install_cpp
    install_lua
    install_rust
    install_go
    install_java
    install_nodejs
    install_docker
    install_kubernetes
    install_containerd
    
    success "WSL setup complete!"
}

# Determine environment and run appropriate setup
if grep -qi microsoft /proc/version &>/dev/null; then
    info "Detected WSL environment"
    wsl "$@"
else
    info "Detected native Linux environment"
    linux_desktop "$@"
fi