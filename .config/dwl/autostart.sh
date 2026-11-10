#!/bin/sh
# Run by dwl -s once the Wayland socket exists. dwl kills this process group
# (so everything started here) when it exits.

# D-Bus-activated services (xdg-desktop-portal for file pickers) need the Wayland socket
dbus-update-activation-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

# PipeWire: systemd user units start it (NixOS); Alpine needs the launcher
[ -x /usr/libexec/pipewire-launcher ] && /usr/libexec/pipewire-launcher 2>/dev/null &
fnott &
# wbg "$HOME/.config/wallpaper.png" &
idle start &   # swayidle; pause/resume it from the session menu
foot --server &
wl-clip-persist --clipboard regular &
wl-paste --watch cliphist store &

brightness restore &   # last level before reboot

# Fill the status bar's volume field once PipeWire is up
(i=0; while [ $i -lt 10 ] && ! volume refresh 2>/dev/null; do sleep 1; i=$((i + 1)); done) &

wait
