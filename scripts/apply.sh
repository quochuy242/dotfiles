#!/usr/bin/env bash
source "$(dirname "$0")/functions.sh"

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"

link_config() {
    local src="$1"
    local dest="$2"
    
    if [ ! -e "$src" ]; then
        warn "Source not found: $src"
        return 1
    fi
    
    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$dest")"
    
    # Remove existing symlink or backup existing file
    if [ -L "$dest" ]; then
        info "Removing existing symlink: $dest"
        rm "$dest"
    elif [ -e "$dest" ]; then
        info "Backing up existing file: $dest -> ${dest}.bak"
        mv "$dest" "${dest}.bak"
    fi
    
    # Create symlink
    ln -s "$src" "$dest"
    success "Linked: $dest -> $src"
}

apply_cli() {
    section "Applying CLI configurations"
    
    # Dotfiles
    link_config "$DOTFILES_DIR/cli/.zshrc" "$HOME/.zshrc"
    link_config "$DOTFILES_DIR/cli/.profile" "$HOME/.profile"
    link_config "$DOTFILES_DIR/cli/starship.toml" "$HOME/.config/starship.toml"
    
    # Config directories
    link_config "$DOTFILES_DIR/cli/nvim" "$HOME/.config/nvim"
    link_config "$DOTFILES_DIR/cli/tmux" "$HOME/.config/tmux"
    link_config "$DOTFILES_DIR/cli/zsh" "$HOME/.config/zsh"
    link_config "$DOTFILES_DIR/cli/bat" "$HOME/.config/bat"
    link_config "$DOTFILES_DIR/cli/atuin" "$HOME/.config/atuin"
    link_config "$DOTFILES_DIR/cli/lazygit" "$HOME/.config/lazygit"
    link_config "$DOTFILES_DIR/cli/yazi" "$HOME/.config/yazi"
    link_config "$DOTFILES_DIR/cli/zathura" "$HOME/.config/zathura"
    link_config "$DOTFILES_DIR/cli/btop" "$HOME/.config/btop"
    link_config "$DOTFILES_DIR/cli/fastfetch" "$HOME/.config/fastfetch"
}

apply_gui() {
    section "Applying GUI configurations"
    
    # Hyprland
    link_config "$DOTFILES_DIR/gui/hypr" "$HOME/.config/hypr"
    
    # Terminal emulators
    link_config "$DOTFILES_DIR/gui/kitty" "$HOME/.config/kitty"
    link_config "$DOTFILES_DIR/gui/alacritty" "$HOME/.config/alacritty"
    
    # Application configurations
    link_config "$DOTFILES_DIR/gui/rofi" "$HOME/.config/rofi"
    link_config "$DOTFILES_DIR/gui/dunst" "$HOME/.config/dunst"
    link_config "$DOTFILES_DIR/gui/waybar" "$HOME/.config/waybar"
    
    # Environment and autostart
    link_config "$DOTFILES_DIR/gui/environment.d" "$HOME/.config/environment.d"
    link_config "$DOTFILES_DIR/gui/autostart" "$HOME/.config/autostart"
}

main() {
    require_arch
    
    info "Starting dotfiles configuration setup..."
    info "Dotfiles directory: $DOTFILES_DIR"
    

    # Determine environment and run appropriate setup
    if grep -qi microsoft /proc/version &>/dev/null; then
        info "Detected WSL environment"
    else
        info "Detected native Linux environment"
        apply_gui
    fi
    apply_cli

    
    success "All configurations applied successfully!"
    info "Some configurations may require a restart to take effect"
}

main "$@"

