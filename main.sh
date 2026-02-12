#!/bin/bash
set -e

SCRIPT_NAME="$(basename "$0")"

help() {
    cat <<EOF
Usage:
  $SCRIPT_NAME [MODE]

MODE (required):
  link    Create symbolic links (classic dotfiles)
  bind    Use bind mount (recommended for external drives / WSL)

Examples:
  $SCRIPT_NAME link
  $SCRIPT_NAME bind

Notes:
  • link  = fast, no root needed, but fragile if source disappears
  • bind  = kernel mount, stable for dev, requires sudo

EOF
}

MODE="$1"

if [[ -z "$MODE" ]]; then
    echo "ERROR: Missing MODE"
    help
    exit 1
fi

case "$MODE" in
    link|bind)
        export DOTFILES_MODE="$MODE"
        ;;
    -h|--help|help)
        help
        exit 0
        ;;
    *)
        echo "ERROR: Invalid MODE: $MODE"
        help
        exit 1
        ;;
esac

source "$(dirname "$0")/scripts/functions.sh"
source "$(dirname "$0")/scripts/install.sh"
source "$(dirname "$0")/scripts/apply.sh"
