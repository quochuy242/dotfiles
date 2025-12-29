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
  alias gcm='git commit'
  alias gps='git push'
  alias gpl='git pull'
  alias gst='git status'
  alias gb='git branch'
  alias gco='git checkout'
fi

# Package manager (Fedora)
alias pmin='sudo dnf install'
alias pmup='sudo dnf -y upgrade'
alias pmli='rpm -qa'
alias pmrm='sudo dnf remove'
