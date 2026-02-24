#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/.."

source "$SCRIPT_DIR/functions.sh"

if [[ -z "$DOTFILES_MODE" ]]; then
    error "DOTFILES_MODE not set. Run via main.sh [link|bind]"
    exit 1
fi


bind_config() {
    local src="$1"
    local dest="$2"

    if [ ! -e "$src" ]; then
        warn "Source not found: $src"
        return 1
    fi

    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$dest")"

    # If already mounted →  skip
    if mountpoint -q "$dest"; then
        info "Already mounted: $dest"
        return 0
    fi

    # Backup existing destination
    if [ -e "$dest" ] && [ ! -d "$dest" ]; then
        info "Backing up existing file: $dest -> ${dest}.bak"
        mv "$dest" "${dest}.bak"
    fi

    # Ensure dest exists (file or dir)
    if [ -d "$src" ]; then
        mkdir -p "$dest"
    else
        touch "$dest"
    fi

    sudo mount --bind "$src" "$dest"

    success "Bind mounted: $dest <- $src"

}

persist_mount() {
    local src="$1"
    local dest="$2"

    if ! grep -qs "$src $dest" /etc/fstab; then
        echo "$src $dest none bind 0 0" | sudo tee -a /etc/fstab > /dev/null
        info "Persisted in fstab: $dest"
    fi
}

apply_config() {
    local src="$1"
    local dest="$2"

    case "$DOTFILES_MODE" in
        link)
            link_config "$src" "$dest"
            ;;
        bind)
            bind_config "$src" "$dest"
            ;;
        *)
            error "Unknown mode: $DOTFILES_MODE"
            exit 1
            ;;
    esac
}


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

    local files=(
        ".zshrc:.zshrc"
        ".profile:.profile"
        "starship.toml:.config/starship.toml"
    )

    local dirs=(
        "nvim:.config/nvim"
        "tmux:.config/tmux"
        "zsh:.config/zsh"
        "bat:.config/bat"
        "atuin:.config/atuin"
        "lazygit:.config/lazygit"
        "yazi:.config/yazi"
        "zathura:.config/zathura"
        "btop:.config/btop"
        "fastfetch:.config/fastfetch"
    )

    for pair in "${files[@]}"; do
        IFS=: read -r src dest <<< "$pair"
        apply_config "$DOTFILES_DIR/cli/$src" "$HOME/$dest"
    done

    for pair in "${dirs[@]}"; do
        IFS=: read -r src dest <<< "$pair"
        apply_config "$DOTFILES_DIR/cli/$src" "$HOME/$dest"
    done
}


apply_gui() {
    section "Applying GUI configurations"

    local dirs=(
        "hypr:.config/hypr"
        "kitty:.config/kitty"
        "alacritty:.config/alacritty"
        "rofi:.config/rofi"
        "dunst:.config/dunst"
        "waybar:.config/waybar"
        "environment.d:.config/environment.d"
        "autostart:.config/autostart"
    )

    for pair in "${dirs[@]}"; do
        IFS=: read -r src dest <<< "$pair"
        apply_config "$DOTFILES_DIR/gui/$src" "$HOME/$dest"
    done
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

