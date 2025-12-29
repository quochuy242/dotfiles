#!/bin/bash
set -e

# Source helper functions if needed
source "$(dirname "$0")/functions.sh"

# Source install & setup scripts
source "$(dirname "$0")/install.sh"

# Source apply setup scripts
source "$(dirname "$0")/apply.sh"