# ----- Zinit -----
source "$HOME/.config/zsh/zinit.zsh"

# ----- Zsh options -----
setopt autocd              # change directory just by typing its name
setopt correct             # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

# ----- Keybindings ------
bindkey "^[[A" history-beginning-search-backward  # search history with up key
bindkey "^[[B" history-beginning-search-forward   # search history with down key

# ----- Starship -----
type starship_zle-keymap-select >/dev/null || \
{
  eval "$(starship init zsh)"
}

# ----- History -----
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# ----- Bat (better cat) -----
export BAT_THEME=tokyonight_night

# ---- FZF -----
source "$HOME/.config/zsh/fzf.zsh"

# --- pipx autocompletion ---
autoload -U compinit && compinit   # If it's not exist
autoload -U bashcompinit           # for bash-style completions
bashcompinit
eval "$(register-python-argcomplete pipx)"

# Created by `pipx` on 2024-12-10 08:14:04
export PATH="$PATH:/home/quochuy242/.local/bin"

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

# ---- Rust -----
. "$HOME/.cargo/env"
export PATH="$HOME/.cargo/bin:$PATH"

# ---- Atuin -----
eval "$(atuin init zsh)"

# ---- Alias -----
source "$HOME/.config/zsh/aliases.zsh"

# ---- Zstyle -----
source "$HOME/.config/zsh/zstyle.zsh"

# ---- Functions -----
source "$HOME/.config/zsh/functions.zsh"

# ---- Golang -----
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOBIN"

# ----- Other config -----
export KEYTIMEOUT=50
export EZA_CONFIG_DIR="$HOME/.config/eza/"
export EDITOR=nvim
