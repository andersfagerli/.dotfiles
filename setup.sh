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
fc-cache -fv

# nvim
rm -rf ${HOME}/.config/nvim
ln -s ${HOME}/.dotfiles/nvim ${HOME}/.config/

# polybar
rm -rf ${HOME}/.config/polybar
ln -s ${HOME}/.dotfiles/polybar ${HOME}/.config/
chmod u+x ${HOME}/.dotfiles/polybar/launch.sh

# ranger
rm -rf ${HOME}/.config/ranger
ln -s ${HOME}/.dotfiles/ranger ${HOME}/.config/

# zsh setup
rm -f ${HOME}/.zshrc
ln -s ${HOME}/.dotfiles/.zshrc ${HOME}/.zshrc

# alacritty
rm -rf ${HOME}/.config/alacritty
ln -s ${HOME}/.dotfiles/alacritty ${HOME}/.config/

# profile
rm -f ${HOME}/.profile
ln -s ${HOME}/.dotfiles/profile/.profile ${HOME}/.profile

# bin
sudo chmod u+x ${HOME}/.dotfiles/bin
