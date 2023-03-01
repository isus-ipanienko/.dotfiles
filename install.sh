#!/usr/bin/env bash
STOW_FOLDERS="X11,i3,kitty,nvim,picom,scripts,tmux,wallpapers,zsh"
DOTFILES=$HOME/.dotfiles

if [ "$1" == "--fresh" ]
then
    echo "installing dependencies..."
    sudo pacman --noconfirm --needed -Sy stow \
            curl ca-certificates ntp dosfstools exfat-utils ntfs-3g p7zip \
            pipewire-pulse wireplumber pamixer networkmanager-openvpn \
            networkmanager network-manager-applet gnome-keyring openvpn \
            xorg-server xorg-xinit xorg-xmodmap xdotool acpilight \
            i3-wm picom slock feh dunst scrot \
            ttf-sazanami ttf-liberation ttf-dejavu \
            base-devel git gitui kitty zsh tmux neovim fzf ripgrep \
            clang llvm lldb rustup rust-analyzer pyright lua-language-server \
            ncspot mpv firefox keepassxc steam xdg-desktop-portal-gnome

    sudo systemctl enable NetworkManager

    git clone https://github.com/isus-ipanienko/zsh-fzf $HOME/.zsh/zsh-fzf
    git clone https://github.com/isus-ipanienko/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions
    git clone https://github.com/isus-ipanienko/zsh-syntax-highlighting $HOME/.zsh/zsh-syntax-highlighting

    mkdir $HOME/Git
    git clone https://aur.archlinux.org/wiki-tui.git $HOME/Git/wiki-tui

    echo "password: "
    chsh -s /bin/zsh $USER >/dev/null 2>&1
fi

pushd $DOTFILES
for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
    echo "create $folder"
    stow -D $folder
    stow $folder
done
popd
