#!/bin/bash

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
    alias ga='git add'
    alias gcm='git commit'
    alias gps='git push'
    alias gpl='git pull'
    alias gst='git status'
    alias gb='git branch'
    alias gco='git checkout'
    alias gl='git log --oneline --graph --decorate --all'
    alias g='git'
fi

# Package manager (Fedora)
alias pmin='sudo pacman -S'
alias pmup='sudo pacman -Syu'
alias pmli='sudo pacman -Qi'
alias pmrm='sudo pacman -Rns'

if [[ -x "$(command -v yay)" ]]; then
    alias aurin='yay -S'
    alias aurup='yay -Syu'
    alias aurl='yay -Qi'
    alias aurrm='yay -Rns'
fi

# Neovim
if [[ -x "$(command -v nvim)" ]]; then
    alias vim='nvim'
    alias svi='sudo nvim'
fi