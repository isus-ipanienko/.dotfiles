#!/usr/bin/env bash
STOW_FOLDERS="X11,i3,kitty,nvim,picom,polybar,rofi,scripts,tmux,wallpapers,zsh"
DOTFILES=$HOME/.dotfiles

if [ "$1" == "--fresh" ]
then
    echo "installing dependencies..."
    sudo pacman --noconfirm --needed -Sy stow \
            xorg-server xorg-xinit xorg-xmodmap xdotool acpilight ttf-sazanami \
            i3-wm picom polybar rofi rofimoji slock feh dunst scrot python-pywal \
            curl ca-certificates ntp dosfstools exfat-utils ntfs-3g p7zip \
            networkmanager network-manager-applet gnome-keyring openvpn \
            pipewire-pulse wireplumber pamixer networkmanager-openvpn \
            lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings atool \
            base-devel git gitui kitty zsh tmux neovim fzf ripgrep \
            clang llvm lldb rustup rust-analyzer pyright lua-language-server \
            ncspot mpv firefox keepassxc flatpak xdg-desktop-portal-gnome

    sudo systemctl enable lightdm
    sudo systemctl enable NetworkManager

    git clone https://github.com/isus-ipanienko/zsh-fzf $HOME/.zsh/zsh-fzf
    git clone https://github.com/isus-ipanienko/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions
    git clone https://github.com/isus-ipanienko/zsh-syntax-highlighting $HOME/.zsh/zsh-syntax-highlighting

    mkdir $HOME/Git
    git clone https://aur.archlinux.org/nerd-fonts-noto.git $HOME/Git/nerd-fonts-noto
    git clone https://aur.archlinux.org/wiki-tui.git $HOME/Git/wiki-tui

    flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak install flathub com.discordapp.Discord

    echo "password: "
    chsh -s /bin/zsh $USER >/dev/null 2>&1

    chmod +x polybar/.config/polybar/*.sh

    wal --theme base16-gruvbox-hard
fi

pushd $DOTFILES
for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
    echo "create $folder"
    stow -D $folder
    stow $folder
done
popd
