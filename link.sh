#!/usr/bin/env bash

mkdir ~/.config
mkdir ~/.scripts
ln -sf ~/.dotfiles/config/* ~/.config
ln -sf ~/.dotfiles/scripts/* ~/.scripts
ln -sf ~/.dotfiles/home/.* ~
