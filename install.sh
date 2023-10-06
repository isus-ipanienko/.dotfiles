#!/usr/bin/env bash
sudo pacman --noconfirm --needed -Sy \
        curl ca-certificates ntp dosfstools exfat-utils ntfs-3g p7zip \
        pipewire-pulse wireplumber pamixer networkmanager-openvpn \
        networkmanager network-manager-applet gnome-keyring openvpn \
        i3-wm picom slock feh dunst scrot acpilight xclip \
        ttf-sazanami ttf-liberation ttf-dejavu noto-fonts-emoji \
        base-devel git gitui kitty zsh tmux neovim fzf ripgrep fd \
        clang llvm lldb rustup rust-analyzer pyright lua-language-server go \
        ncspot mpv imv firefox keepassxc steam xdg-desktop-portal-gnome

sudo systemctl enable NetworkManager

git clone https://github.com/isus-ipanienko/zsh-fzf $HOME/.zsh/zsh-fzf
git clone https://github.com/isus-ipanienko/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions
git clone https://github.com/isus-ipanienko/zsh-syntax-highlighting $HOME/.zsh/zsh-syntax-highlighting

mkdir $HOME/Git
git clone https://aur.archlinux.org/wiki-tui.git $HOME/Git/wiki-tui

echo "changing shell to zsh\npassword: "
chsh -s /bin/zsh $USER >/dev/null 2>&1

mkdir ~/.config
mkdir ~/.scripts
ln -sf ~/.dotfiles/config/* ~/.config
ln -sf ~/.dotfiles/scripts/* ~/.scripts
ln -sf ~/.dotfiles/home/.* ~
