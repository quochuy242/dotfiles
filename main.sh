#!/usr/bin/env bash
set -euo pipefail

SCRIPT_NAME="$(basename "$0")"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

MODE="link"
DRY_RUN=false
ACTION=""

log() {
    echo "[dotfiles] $*"
}

die() {
    echo "[dotfiles:ERROR] $*" >&2
    exit 1
}

help() {
cat <<EOF
Usage:
  $SCRIPT_NAME <command> [options]

Commands:
  install        Install dependencies
  apply          Apply dotfiles
  setup          Install + apply

Options:
  --mode link    Use symbolic links (default)
  --mode bind    Use bind mount
  --dry-run      Show actions without executing
  -h, --help     Show this help

Examples:
  $SCRIPT_NAME install
  $SCRIPT_NAME apply --mode link
  $SCRIPT_NAME setup --mode bind
EOF
}

run() {
    if [[ "$DRY_RUN" == true ]]; then
        echo "[dry-run] $*"
    else
        "$@"
    fi
}

parse_args() {

    [[ $# -eq 0 ]] && help && exit 1

    ACTION="$1"
    shift

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --mode)
                MODE="$2"
                shift 2
                ;;
            --dry-run)
                DRY_RUN=true
                shift
                ;;
            -h|--help)
                help
                exit 0
                ;;
            *)
                die "Unknown argument: $1"
                ;;
        esac
    done

    case "$MODE" in
        link|bind) ;;
        *) die "Invalid mode: $MODE" ;;
    esac
}

load_scripts() {
    source "$SCRIPT_DIR/scripts/functions.sh"
}

cmd_install() {
    log "Running install (mode=$MODE)"
    source "$SCRIPT_DIR/scripts/install.sh"
}

cmd_apply() {
    log "Running apply (mode=$MODE)"
    source "$SCRIPT_DIR/scripts/apply.sh"
}

cmd_setup() {
    cmd_install
    cmd_apply
}

main() {

    parse_args "$@"

    export DOTFILES_MODE="$MODE"

    load_scripts

    case "$ACTION" in
        install) cmd_install ;;
        apply) cmd_apply ;;
        setup) cmd_setup ;;
        *) die "Unknown command: $ACTION" ;;
    esac
}

main "$@"