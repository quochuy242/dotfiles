#!/bin/bash
set -e  # Exit on error

source "$(dirname "$0")/functions.sh"

# === Init ===
print_section "Updating system"
sudo pacman -Syu --noconfirm

# === Install yay-bin ===
print_section "Installing yay-bin AUR helper"
if ! command -v yay &>/dev/null; then
  git clone https://aur.archlinux.org/yay-bin.git ~/yay
  cd ~/yay && makepkg -si --noconfirm && cd ~
else
  print_info "yay is already installed"
fi

# === Package Groups ===
declare -a dependencies=(
  git base-devel hyprland pipewire ffmpeg playerctl kitty stow unzip
  xdg-desktop-portal-hyprland polkit-kde-agent qt5-wayland qt6-wayland
  brightnessctl cliphist dunst pamixer
)

declare -a fonts=(
  ttf-cascadia-code-nerd ttf-cascadia-mono-nerd ttf-fira-code ttf-fira-mono
  ttf-fira-sans ttf-firacode-nerd ttf-iosevka-nerd ttf-iosevkaterm-nerd
  ttf-jetbrains-mono-nerd ttf-jetbrains-mono ttf-nerd-fonts-symbols
  ttf-nerd-fonts-symbols-mono adwaita-fonts
)

declare -a theming=( papirus-icon-theme )
declare -a aur_theming=( catppuccin-gtk-theme-mocha bibata-cursor-theme )

declare -a hyprland_packages=(
  waybar rofi-wayland swww hyprpicker hyprlock hypridle
  nwg-look qt5ct qt6ct kvantum bluez bluez-utils
)

declare -a aur_utils=( grimblast cava bemoji )
declare -a apps=( obs-studio obsidian pavucontrol mpv imv telegram-desktop )
declare -a aur_apps=( brave-bin zen-browser-bin zoom visual-studio-code-bin )

# === Install All Packages ===
print_section "Installing dependencies"
for pkg in "${dependencies[@]}"; do install_package "$pkg"; done

print_section "Installing fonts"
for font in "${fonts[@]}"; do install_package "$font"; done

print_subsection "Installing icon theme"
for theme in "${theming[@]}"; do install_package "$theme"; done

print_subsection "Installing GTK theme"
for aur_theme in "${aur_theming[@]}"; do install_aur_package "$aur_theme"; done

print_section "Installing Hyprland-related packages"
for pkg in "${hyprland_packages[@]}"; do install_package "$pkg"; done

print_section "Installing extra AUR tools"
for pkg in "${aur_utils[@]}"; do install_aur_package "$pkg"; done

print_section "Installing desktop applications"
for app in "${apps[@]}"; do install_package "$app"; done
for app in "${aur_apps[@]}"; do install_aur_package "$app"; done

# === Wallpapers ===
print_section "Downloading wallpapers"
wallpaper_dir="$HOME/wallpapers/"
read -p "Do you want to download my wallpapers (CAUTION: >= 1.1GB) (y/n): " answer
answer=${answer,,}

if [[ "$answer" == "y" || "$answer" == "yes" ]]; then
  if [ -d "$wallpaper_dir" ]; then
    print_info "The $wallpaper_dir exists"
    read -p "Do you want to remove your wallpaper (y/n): " remove_choice
    remove_choice=${remove_choice,,}
    [[ "$remove_choice" == "y" || "$remove_choice" == "yes" ]] && rm -rf "$wallpaper_dir" || wallpaper_dir="$HOME/quochuy242_wallpapers"
  fi
  mkdir -p "$wallpaper_dir"
  print_info "Cloning quochuy242's wallpaper collection..."
  git clone https://github.com/quochuy242/wallpapers.git "$wallpaper_dir"
else
  print_info "Skip downloading wallpapers"
fi

# === CLI Tools & Environments ===
print_section "Installing shell environments"
install_package zsh

print_section "Installing configuration tools"
install_package stow

print_section "Installing modern CLI utilities"
for pkg in zoxide eza fd fzf bat ripgrep; do install_package "$pkg"; done

print_section "Installing system monitoring tools"
for pkg in htop btop fastfetch; do install_package "$pkg"; done

print_section "Installing text editors and terminal multiplexers"
for pkg in nano vim neovim tmux; do install_package "$pkg"; done

print_section "Installing file managers"
for pkg in yazi superfile; do install_package "$pkg"; done

print_section "Installing terminal emulators"
for pkg in kitty alacritty; do install_package "$pkg"; done

print_section "Installing shell enhancements"
for pkg in atuin starship; do install_package "$pkg"; done


# === Done ===
print_section "Installation complete!"
print_success "${GREEN}All packages and tools have been installed.${NC}"

