#!/bin/bash

# Git
rm -f ${HOME}/.gitconfig
ln -s ${HOME}/.dotfiles/git/.gitconfig ${HOME}/.gitconfig

# i3
rm -rf ${HOME}/.config/i3
ln -s ${HOME}/.dotfiles/i3 ${HOME}/.config/

# fonts
rm -rf ${HOME}/.local/share/fonts
ln -s ${HOME}/.dotfiles/fonts ${HOME}/.local/share/

# nvim
rm -rf ${HOME}/.config/nvim
ln -s ${HOME}/.dotfiles/nvim ${HOME}/.config/

# ranger
rm -rf ${HOME}/.config/ranger
ln -s ${HOME}/.dotfiles/ranger ${HOME}/.config/

# zsh setup
rm -f ${HOME}/.zshrc
ln -s ${HOME}/.dotfiles/.zshrc ${HOME}/.zshrc

# alacritty
rm -rf ${HOME}/.config/alacritty
ln -s ${HOME}/.dotfiles/alacritty ${HOME}/.config/
