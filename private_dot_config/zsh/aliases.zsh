# Nvim
if [[ -x "$(command -v nvim)" ]]; then
  alias vi='nvim'
  alias vim='nvim'
  alias svi='sudo nvim'
  alias vis='nvim "+set si"'
  alias nv='nvim'
  alias v='nvim'
elif [[ -x "$(command -v vim)" ]]; then
  alias vi='vim'
  alias svi='sudo vim'
  alias vis='vim "+set si"'
  alias v='vim'
fi

# Tmux
if [[ -x "$(command -v tmux)" ]]; then
  alias tm='tmux'
  alias tma='tmux a -t'
  alias tml='tmux list-sessions'
  alias tmd='tmux detach'
fi

# Visual Studio Code
if [[ -x "$(command -v code)" ]]; then
  alias vsc='code --ozone-platform=wayland' # For wayland
fi

# Zoxide
if [[ -x "$(command -v zoxide)" ]]; then
  alias cd='z'
fi

# Eza
if [[ -x "$(command -v eza)" ]]; then
  alias l='eza -la --icons=auto --sort=name --group-directories-first --all'
  alias ll='eza -lha --icons=auto --sort=name --group-directories-first --all'
  alias lt='eza --icons=auto --tree --level=3'
  alias ls='eza --icons=always --color=always --no-permissions --no-user --all'
fi


# Fastfetch
if [[ -x "$(command -v fastfetch)" ]]; then
  alias ff='fastfetch'
fi

# Navigation and safe file operations
alias ..='cd ..'           # Up one directory
alias ...='cd ../..'       # Up two directories
alias ....='cd ../../..'   # Up three directories
alias dot='cd $HOME/dotfiles/'        # Go to dotfiles
alias conf='cd $HOME/.config/'        # Go to config
alias mkd='mkdir -pv'     # Create directories with verbose output
alias rm='rm -iv'         # Remove files with interactive and verbose mode
alias cp='cp -iv'         # Copy files with interactive and verbose mode
alias mv='mv -iv'         # Move files with interactive and verbose mode


# Python
if [[ -x "$(command -v python3)" ]]; then
  alias py='python3'
  alias pyac='source .venv/bin/activate'
  alias pydeac='deactivate'
fi


# Git
if [[ -x "$(command -v git)" ]]; then
  alias gaa='git add .'
  alias gcm='git commit'
  alias gps='git push'
  alias gpl='git pull'
  alias gst='git status'
  alias gitfastpush='git add . && git commit -m "fast push, no info" && git push origin master' # ! Only use it for master branch and commit without message
  alias gb='git branch'
  alias gco='git checkout'
fi

# pacman
alias pmin='sudo pacman -S'
alias pmup='sudo pacman -Syu'
alias pmli='sudo pacman -Q'
alias pmrm='sudo pacman -R'

# Paru
if [[ -x "$(command -v paru)" ]]; then
  alias prin='paru -Sua'
  alias prli='paru -Qua'
  alias prrm='paru -Rs'
  alias prup='paru -Syu'
fi

# Yay
if [[ -x "$(command -v yay)" ]]; then
  alias yain="yay -S"
  alias yarm="yay -R"
  alias yaup='yay -Syu'
  alias yali='yay -Q'
fi

# Aura
if [[ -x "$(command -v aura)" ]]; then
  alias aurm="aura -R"
  alias auin="aura -A"
  alias auup='aura -Syu'
  alias auli='aura -Q'
fi

# Chezmoi
if [[ -x "$(command -v chezmoi)" ]]; then
  alias cz='chezmoi'
  alias czap='chezmoi apply'
  alias czd='chezmoi diff'
  alias czed='chezmoi edit'
fi

# Wifi
if [[ -x "$(command -v iwctl)" ]]; then
  alias wifi-list="iwctl station wlan0 get-networks"
  alias wifi-connect="iwctl station wlan0 connect"
fi
