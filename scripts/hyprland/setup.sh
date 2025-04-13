#!/bin/bash
set -e # Exit on error

# Import the common functions
CURR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURR_DIR/../common.sh"

# Ask user
read -p "Do you want to setup my hyprland ricing? (y/n): " setup_answer
setup_answer=${setup_answer,,} # Convert to lowercase

if [[ "$setup_answer" == "y" || "$setup_answer" == "yes" ]]; then
  
  ### Clone config ###
  if [ -d "$CLONE_DIR" ]; then
    print_info "Directory $CLONE_DIR already exists."
    read -p "Do you want to remove it? (y/n): " remove_answer
    
    if [[ "$remove_answer" == "y" || "$remove_answer" == "yes" ]]; then
      print_info "Removing $CLONE_DIR..."
      rm -rf "$CLONE_DIR"
      
      # Clone the repository
      print_info "Cloning config from ${PURPLE}$REPO_URL${NC} into ${PURPLE}$CLONE_DIR${NC}..."
      git clone "$REPO_URL" "$CLONE_DIR"
    else
      print_info "Skipping removal of ${PURPLE}$CLONE_DIR${NC}."
    fi
    
  fi
  
  ### Install config ###
  print_section "Installing config"
  
  if [ -d "$SCRIPTS_DIR" ]; then
    while true; do
      print_info "Avaliable scripts:"
      
      # List available scripts
      scripts=("$SCRIPTS_DIR"/*.sh)
      for i in "${!scripts[@]}"; do
        script_name=$(basename "${scripts[$i]}")
        echo "[$((i + 1))]: $script_name"
      done
      
      # Prompt user to choose script
      read -p "Enter the number of the script to run: " choice
      
      # Validate choice
      if [[ "$choice" =~ ^[0-9]+$ ]] && ((choice >= 1 && choice <= ${#scripts[@]})); then
        selected_script="${scripts[$((choice - 1))]}"
        print_info "Running ${GREEN}$selected_script${NC}..."
        bash "$selected_script"
        print_info "Script completed successfully."
        break
      else
        print_error "Invalid choice. Please enter a valid number."
        exit 1
      fi
    done
  else
    print_error "No scripts directory found at $SCRIPTS_DIR."
    exit 1
  fi
  
else
  print_info "You chose not to clone config."
fi
