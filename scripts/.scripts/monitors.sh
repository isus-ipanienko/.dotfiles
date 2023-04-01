#!/bin/sh
if [ "$HOSTNAME" = overlord ]; then
    xrandr --output HDMI-0 --primary --mode 3440x1440 --pos 0x1440 --rotate normal --output DP-0 --mode 1920x1080 --pos 3440x960 --rotate left --output DP-1 --off --output DP-2 --mode 2560x1440 --pos 440x0 --rotate normal --output DP-3 --off --output DP-4 --off --output DP-5 --off
    xset s off
fi
