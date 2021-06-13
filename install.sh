#!/bin/bash

# If not connected to network, run "sudo apt install bcmwl-kernel-source" while connected to mobile network, and connect to wireless network before running

sudo apt-get install -y \
	git \
	curl \
	python3-pip \
	feh \
	zathura \
	picom

# Alacritty
if ! [ -x "$(command -v alacritty)" ]; then
	if ! [ -x "$(command -v rustup)" ]; then
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
		source $HOME/.cargo/env
		rustup override set stable
		rustup update stable
	fi

	cargo install alacritty

	sudo cp $HOME/.cargo/bin/alacritty /usr/local/bin
	sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/alacritty 50
	sudo update-alternatives --config x-terminal-emulator
fi

# Chrome
if ! [ -x "$(command -v google-chrome)" ]; then
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i google-chrome-stable_current_amd64.deb
	rm google-chrome-stable_current_amd64.deb
fi

# Spotify
if ! [ -x "$(command -v spotify)" ]; then
	curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
	sudo apt-get update && sudo apt-get install -y spotify-client
fi

# Visual Studio Code
if ! [ -x "$(command -v code)" ]; then
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
	sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
	sudo apt install -y apt-transport-https
	sudo apt update
	sudo apt install -y code
fi

# Neovim
if ! [ -x "$(command -v nvim)" ]; then
	sudo add-apt-repository ppa:neovim-ppa/stable 
	sudo apt-get update
	sudo apt-get install -y neovim
	snap install node --classic
fi

# Ranger
if ! [ -x "$(command -v ranger)" ]; then
	sudo apt install -y ranger
	sudo apt install -y libxext-dev
	pip3 install ueberzug
fi

# i3
if ! [ -x "$(command -v i3)" ]; then
	/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2021.02.02_all.deb keyring.deb SHA256:cccfb1dd7d6b1b6a137bb96ea5b5eef18a0a4a6df1d6c0c37832025d2edaa710
	dpkg -i ./keyring.deb
	echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" >> /etc/apt/sources.list.d/sur5r-i3.list
	sudo apt-get update
	sudo apt-get install -y i3
	sudo apt-get install -y i3blocks
	
	# For i3-gaps
	sudo add-apt-repository ppa:kgilmer/speed-ricer
	sudo apt-get update
	sudo apt install -y i3-gaps

	# For correctly updating volume in i3bar
	sudo apt-get install -y pavucontrol

	# For screen brightness
	sudo apt-get install -y brightnessctl
	sudo gpasswd -a ${USER} video

	# For keybinding
	git clone https://github.com/schischi/xcwd.git
	cd xcwd
	make && sudo make install
	cd ..
	rm -rf xcwd

	# Autotiling
	pip3 install autotiling

	# Betterlockscreen
	sudo apt install -y autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev imagemagick

	git clone https://github.com/Raymo111/i3lock-color.git
	cd i3lock-color
	./install-i3lock-color.sh

	git clone https://github.com/pavanjadhaw/betterlockscreen
	cd betterlockscreen
	cp betterlockscreen ~/.local/bin/

	betterlockscreen -u ${HOME}/.dotfiles/wallpaper/single.png

fi

# Oh-my-zsh
if ! [ -x "$(command -v zsh)" ]; then
	sudo apt-get install -y zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
