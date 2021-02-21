#!/bin/bash

# If not connected to network, run "sudo apt install bcmwl-kernel-source" while connected to mobile network, and connect to wireless network before running

sudo apt-get install -y \
	git \
	curl \
	python3-pip \
	zsh \
	feh \
	zathura

# Chrome
if ! [ -x "$(command -v google-chrome)" ]; then
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i google-chrome-stable_current_amd64.deb
	rm google-chrome-stable_current_amd64.deb
fi

# Spotify
if ! [ -x "$(command -v spotify)" ]; then
	curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
	sudo apt-get update && sudo apt-get install -y spotify-client
fi

# Visual Studio Code
if ! [ -x "$(command -v code)" ]; then
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
	sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
	sudo apt install apt-transport-https
	sudo apt update
	sudo apt install code
fi

# Neovim
if ! [ -x "$(command -v nvim)" ]; then
	sudo add-apt-repository ppa:neovim-ppa/stable 
	sudo apt-get update
	sudo apt-get install neovim
fi

# Ranger
if ! [ -x "$(command -v ranger)" ]; then
	sudo apt install ranger
	git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
	pip3 install ueberzug
fi

# i3
if ! [ -x "$(command -v i3)" ]; then
	/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2020.02.03_all.deb keyring.deb SHA256:c5dd35231930e3c8d6a9d9539c846023fe1a08e4b073ef0d2833acd815d80d48
	dpkg -i ./keyring.deb
	echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee -a /etc/apt/sources.list.d/sur5r-i3.list
	sudo apt-get update
	sudo apt-get install i3
fi

# Oh-my-zsh
if ! [ -x "$(command -v zsh)" ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
