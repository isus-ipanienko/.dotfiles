#!/usr/bin/env bash
STOW_FOLDERS="i3,kitty,nvim,picom,polybar,ranger,tmux,wallpapers,zsh,X11"
DOTFILES=$HOME/.dotfiles

if [ "$1" == "--fresh" ]
then
    echo "installing dependencies..."
    sudo pacman --noconfirm --needed -Sy stow base-devel git \
            curl ca-certificates ntp dosfstools exfat-utils ntfs-3g \
            xorg-server xorg-xinit xorg-xmodmap acpilight \
            networkmanager nm-connection-editor gnome-keyring \
            pipewire-pulse wireplumber pamixer \ 
            lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings atool \
            i3-wm picom polybar dmenu slock feh dunst scrot python-pywal \
            noto-fonts noto-fonts-emoji \
            kitty zsh ranger mpv tmux neovim fzf ripgrep firefox

    sudo systemctl enable lightdm
    sudo systemctl enable NetworkManager

    git clone https://github.com/isus-ipanienko/zsh-fzf $HOME/.zsh/zsh-fzf
    git clone https://github.com/isus-ipanienko/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions
    git clone https://github.com/isus-ipanienko/zsh-syntax-highlighting $HOME/.zsh/zsh-syntax-highlighting

    echo "password: "
    chsh -s /bin/zsh $USER >/dev/null 2>&1

    unzip $DOTFILES/wallpapers/.config/wallpapers/wallpapers.zip -d $DOTFILES/wallpapers/.config/wallpapers
    
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
