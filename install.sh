#!/bin/bash

# If not connected to network, run "sudo apt install bcmwl-kernel-source" while connected to mobile network, and connect to wireless network before running

cd ~

sudo apt update
sudo apt upgrade -y

sudo apt install -y \
    build-essential \
    cmake cmake-doc \
    git \
    curl wget \
    python3 python3-pip \
    feh \
    zathura \

# Alacritty
if ! [ -x "$(command -v alacritty)" ]; then
    if ! [ -x "$(command -v rustup)" ]; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        source $HOME/.cargo/env
        rustup override set stable
        rustup update stable
    fi

    sudo apt-get install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
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
    snap install spotify
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
    /usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2022.02.17_all.deb keyring.deb SHA256:52053550c4ecb4e97c48900c61b2df4ec50728249d054190e8a0925addb12fc6
    dpkg -i ./keyring.deb
    echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" >> /etc/apt/sources.list.d/sur5r-i3.list    
    sudo apt-get update
    sudo apt-get install -y i3
    sudo apt-get install -y i3blocks
    
    # For i3-gaps
    sudo add-apt-repository ppa:regolith-linux/release
    sudo apt update
    sudo apt install -y i3-gaps

    # For correctly updating volume in i3bar
    sudo apt-get install -y pavucontrol

    # For screen brightness
    sudo apt-get install -y brightnessctl
    sudo gpasswd -a ${USER} video

    # For opening new terminal in current directory
    git clone https://github.com/schischi/xcwd.git
    cd xcwd
    make && sudo make install
    cd ..
    rm -rf xcwd

    # Autotiling
    pip3 install autotiling
    
    # Picom (for opacity)
    sudo apt-get install -y libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson
    git clone https://github.com/yshui/picom.git
    cd picom
    git submodule update --init --recursive
    meson --buildtype=release . build
    ninja -C build
    sudo ninja -C build install
    cd ..
    rm -rf picom
    
    # Polybar (and other stuff)
    sudo apt install -y build-essential git cmake cmake-data pkg-config python3-sphinx python3-packaging libuv1-dev libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev
    sudo apt install -y libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev
    git clone --recursive https://github.com/polybar/polybar
    cd polybar
    mkdir build
    cd build
    cmake ..
    make -j$(nproc)
    # Optional. This will install the polybar executable in /usr/local/bin
    sudo make install
    cd ~
    sudo apt install -y rofi calc
    
    # Betterlockscreen
    sudo apt install -y autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev imagemagick

    git clone https://github.com/Raymo111/i3lock-color.git
    cd i3lock-color
    ./install-i3lock-color.sh
    cd ..
    rm -rf i3lock-color

    git clone https://github.com/pavanjadhaw/betterlockscreen
    cd betterlockscreen
    cp -rf betterlockscreen ${HOME}/.dotfiles/bin
    
    chmod u+x betterlockscreen
    ./betterlockscreen -u ${HOME}/.dotfiles/wallpaper/single.png

    cd ~
    rm -rf betterlockscreen
fi

# Oh-my-zsh
if ! [ -x "$(command -v zsh)" ]; then
    sudo apt-get install -y zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi


