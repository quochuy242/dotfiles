set -a
source ~/.config/.env
set +a

source $HOME/.config/zsh/main.zsh

# Added by GitLab Knowledge Graph installer
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"

# OpenClaw Completion
source "/home/quochuy242/.openclaw/completions/openclaw.zsh"

# opencode
export PATH=/home/quochuy242/.opencode/bin:$PATH
