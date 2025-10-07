#!/bin/bash
set -e  # Exit on error

# -----------------------------
# Setup functions
# -----------------------------
setup_rust() {
  print_section "Setup Rust"
  install_package rustup
  if command -v rustup &>/dev/null; then
    rustup default stable
    print_success "Rust installed successfully."
  else
    print_error "Rustup not found."
  fi
}

setup_docker() {
  print_section "Setup Docker & Podman"
  install_package docker
  install_package docker-compose
  install_package podman
  install_aur_package lazydocker-bin

  print_info "Enabling docker service"
  sudo systemctl enable --now docker.service

  if sudo systemctl is-active --quiet docker.service; then
    print_success "Docker service is running."
  else
    print_error "Docker service failed to start."
  fi

  sudo usermod -aG docker "$USER"
  print_info "Added $USER to docker group. Please log out and log back in to apply changes."
}

setup_r() {
  print_section "Setup R & languageserver"
  install_package r
  mkdir -p "$HOME/.local/share/R/library/"
  R -e 'install.packages("languageserver", repos="https://cloud.r-project.org", lib="~/.local/share/R/library")'
}

setup_cpp_lua() {
  print_section "Setup C/C++ & Lua"
  install_package clang
  install_package base-devel
  install_package gcc
  install_package lua
  install_package luarocks
}

setup_python() {
  print_section "Setup Python"
  install_package python
  install_package python-pip
  install_package python-pipx
  install_package python-virtualenv
  install_package uv
  pipx ensurepath
  pipx install completions
  pipx install speedtest-cli
}

setup_go() {
  print_section "Setup Golang"
  install_package go
}

setup_node() {
  print_section "Setup Node.js and npm"
  install_package nodejs
  install_package npm
}

setup_tmux() {
  print_section "Setup tmux"
  if [ ! -d "$HOME/.config/tmux/plugins/tpm" ]; then
    print_subsection "Installing Tmux Plugin Manager"
    mkdir -p ~/.config/tmux/plugins/tpm
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
  else
    print_subsection "Tmux Plugin Manager is already installed"
  fi
}


setup_bat() {
  print_section "Building bat cache"
  bat cache --build
}
 

setup_zsh() {
  print_section "Setting up zsh"
  touch ~/.zshrc
  if ! grep -qxF "source \$HOME/dotfiles/zsh/main.zsh" ~/.zshrc; then
    echo "source \$HOME/dotfiles/zsh/main.zsh" >>~/.zshrc
  fi
  source ~/.zshrc
}

setup_atuin() {
  print_section "Setup atuin"
  install_package atuin
  
  read -p "Do you have an account on atuin? (y/n): " answer
  answer=${answer,,}
    
  if [[ "$answer" == "y" || "$answer" == "yes" ]]; then
    print_info "You've had an account on atuin"
    atuin login
  elif [[ "$answer" == "n" || "$answer" == "no" ]]; then
    print_info "You haven't had an account on atuin, skipping"
    print_info "Please create an account on atuin by run 'atuin register -u <USERNAME> -e <EMAIL>'"
  fi

  print_info "Starting sync"
  atuin sync
}


# -----------------------------
# Main
# -----------------------------
main() {
  setup_rust
  setup_docker
  setup_r
  setup_cpp_lua
  setup_python
  setup_go
  setup_node
  setup_tmux
  setup_bat
  setup_zsh
  print_success "✅ All setups completed!"
  print_info "You may need to log out and back in for changes to take effect."
  print_info "To apply Tmux plugins, press prefix + I inside tmux."
}

main "$@"

