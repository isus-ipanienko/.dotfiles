#!/usr/bin/env bash
sudo pacman --noconfirm --needed -Sy \
        mako wl-clipboard firefox chromium ncspot mpv imv keepassxc steam \
        ttf-sazanami ttf-liberation ttf-dejavu ttf-font-awesome noto-fonts-emoji \
        curl ca-certificates ntp dosfstools exfat-utils ntfs-3g p7zip \
        gnome-keyring xdg-desktop-portal-gnome network-manager-applet \
        base-devel gitui kitty zsh tmux neovim fzf ripgrep fd \
        cmake clang llvm lldb rustup go zig

git clone https://github.com/isus-ipanienko/zsh-fzf $HOME/.zsh/zsh-fzf
git clone https://github.com/isus-ipanienko/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions
git clone https://github.com/isus-ipanienko/zsh-syntax-highlighting $HOME/.zsh/zsh-syntax-highlighting

echo "changing shell to zsh\npassword: "
chsh -s /bin/zsh $USER >/dev/null 2>&1

mkdir ~/.config
mkdir ~/.scripts
ln -sf ~/.dotfiles/config/* ~/.config
ln -sf ~/.dotfiles/scripts/* ~/.scripts
ln -sf ~/.dotfiles/home/.* ~
