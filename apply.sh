#!/usr/bin/env bash
source "$(dirname "$0")/functions.sh"

main() {
    install_pkg stow
    stow -t "$HOME" home/
}

main "$@"