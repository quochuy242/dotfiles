#!/bin/bash

SCRIPTS_DIR="$HOME/.local/bin"

# Get the list of scripts
scripts=$(find "$SCRIPTS_DIR" -maxdepth 1 -type f -executable -printf "%f\n")

# Show the list of scripts using rofi 
chosen=$(echo "$scripts" | rofi -dmenu -theme ~/.config/rofi/default.rasi -p "CMD:")

# Execute the chosen script
if [ -n "$chosen" ]; then
    "$SCRIPTS_DIR/$chosen" &
fi

