#!/bin/sh
# Run by glasswm -s once the Wayland socket exists. glasswm kills this process group
# (so everything started here) when it exits. glasswm draws the wallpaper itself.

# D-Bus-activated services (xdg-desktop-portal for file pickers) need the Wayland socket
dbus-update-activation-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
# The portal also needs graphical-session.target, which glasswm-session.target binds
systemctl --user start glasswm-session.target
trap 'systemctl --user stop glasswm-session.target' EXIT TERM

fnott &
idle start &   # swayidle; pause/resume it from the session menu
foot --server &
wl-clip-persist --clipboard regular &
wl-paste --watch cliphist store &

battery-watch &        # warns when a battery is under 15%
brightness restore &   # last level before reboot

# Fill the status bar's volume field once PipeWire is up
(i=0; while [ $i -lt 10 ] && ! volume refresh 2>/dev/null; do sleep 1; i=$((i + 1)); done) &

wait
