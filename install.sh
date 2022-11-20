#!/usr/bin/env bash
STOW_FOLDERS="i3,kitty,nvim,picom,ranger,tmux,wallpapers,zsh"
DOTFILES=$HOME/.dotfiles

if [ "$1" == "--fresh" ]
then
    echo "installing dependencies..."
    sudo pacman --noconfirm --needed -Sy stow base-devel git fzf ripgrep \
            curl ca-certificates ntp dosfstools exfat-utils ntfs-3g \
            networkmanager network-manager-applet gnome-keyring pipewire-pulse wireplumber \
            xorg-server xorg-xinit xorg-xmodmap xorg-xbacklight \
            i3-wm i3status dmenu picom slock feh ranger scrot dunst \
            lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings \
            noto-fonts noto-fonts-emoji \
            mpv kitty zsh tmux neovim firefox

    sudo systemctl enable lightdm
    sudo systemctl enable NetworkManager

    git clone https://github.com/isus-ipanienko/zsh-fzf $HOME/.zsh/zsh-fzf
    git clone https://github.com/isus-ipanienko/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions
    git clone https://github.com/isus-ipanienko/zsh-syntax-highlighting $HOME/.zsh/zsh-syntax-highlighting

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
