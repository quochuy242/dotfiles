#!/bin/bash

## Install plugins
echo -e "\n\nClone zsh-autocomplete, zsh-autosuggestion and zsh-fast-syntax-highlighting\n\n"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

# Install TPM
echo -e "\n\nClone Tmux Plugin Manager\n\n"
mkdir -p ~/.config/tmux/plugins/tpm 
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# Setup bat
bat cache --build

# Setup by stow
stow .
