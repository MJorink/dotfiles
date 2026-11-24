# ~/.profile: login shells

# History lives in a kept directory, not $HOME: on NixOS $HOME is wiped at boot
# and only listed directories survive (bash also saves history by rename).
export HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/sh_history"
export HISTFILESIZE=8192 HISTSIZE=8192
export EDITOR=nvim
export VISUAL=nvim
export PATH="$HOME/.local/bin:$HOME/.dotnet/tools:$PATH" # dotnet tools: csharp-ls
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_NOLOGO=1
export LIBVA_DRIVER_NAME=iHD         # VA-API driver for the HD 620
# Claude Code then keeps .claude.json inside ~/.claude: one directory holds all its state
export CLAUDE_CONFIG_DIR="$HOME/.claude"

# bemenu (app launcher and menu-* scripts): vim bindings and 8 lines. The
# packages repo's bemenu draws the Spotlight look itself (size, corners,
# colours) and ignores the look options below; they style a stock bemenu
# (non-Nix systems) in the same macOS colours. The menu-* scripts add --vim-normal-mode.
export BEMENU_OPTS="--binding vim --vim-esc-exits -i -w -c -l '8 down' -W 0.45 -B 1 -R 12 -H 32
	--fn 'Inter Variable 12' --bdr '#ffffff1a'
	--tb '#1e1e1e20' --tf '#ffffff99' --fb '#1e1e1e20' --ff '#ffffff' --cb '#ffffff80' --cf '#ffffff'
	--nb '#1e1e1e20' --nf '#ffffffd9' --ab '#1e1e1e20' --af '#ffffffd9' --hb '#0a84ff' --hf '#ffffff'"

# Start the glasswm session on tty1 only.
if [ -z "${WAYLAND_DISPLAY:-}" ] && [ "$(tty)" = /dev/tty1 ]; then
	# logind sets XDG_RUNTIME_DIR; systemd's user bus is the session bus
	exec "$HOME/.local/bin/dwl-session"
fi
