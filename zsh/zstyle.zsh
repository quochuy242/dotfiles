# fzf-tab
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' fzf-flags --color=fg:#d0d0d0,fg+:#d0d0d0,bg:#000000,bg+:#414868 \
    --color=hl:#7aa2f7,hl+:#5fd7ff,info:#e0af68,marker:#9ece6a \
    --color=prompt:#ff007c,spinner:#bb9af7,pointer:#9d7cd8,header:#4fd6be \
    --color=border:#a9b1d6,label:#aeaeae,query:#d9d9d9 \
    --border="none" --border-label="" --preview-window="border-sharp" \
    --prompt="🔍 " --marker="✓" --pointer="▶" \
    --separator="─" --scrollbar="│" --layout="reverse" \
    --bind=alt-a:select-all --bind=alt-d:deselect-all --bind=tab:accept
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

