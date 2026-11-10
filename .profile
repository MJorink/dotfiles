# ~/.profile: login shells (BusyBox ash on Alpine, bash on NixOS)

export ENV="$HOME/.ashrc"            # interactive ash reads ~/.ashrc (bash: ~/.bashrc)
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

# bemenu (app launcher and menu-* scripts): vim bindings, caelus colours.
# The menu-* scripts (menu-apps too) add --vim-normal-mode.
export BEMENU_OPTS="--binding vim --vim-esc-exits -i -w -c -l '10 down' -W 0.4 -B 1 -H 24
	--fn 'JetBrainsMonoNL Nerd Font Mono 11' --bdr '#ef934d'
	--tb '#141514' --tf '#ef934d' --fb '#141514' --ff '#f4decd' --cb '#141514' --cf '#f4decd'
	--nb '#141514' --nf '#f4decd' --ab '#141514' --af '#f4decd' --hb '#ef934d' --hf '#141514'"

# Start dwl on tty1 only.
if [ -z "${WAYLAND_DISPLAY:-}" ] && [ "$(tty)" = /dev/tty1 ]; then
	# logind (NixOS) sets XDG_RUNTIME_DIR; without it (Alpine) make one in /tmp
	if [ -z "${XDG_RUNTIME_DIR:-}" ]; then
		dir="/tmp/$(id -u)-runtime"
		mkdir -m 0700 "$dir" 2>/dev/null
		# /tmp is shared: refuse a symlink or a directory someone else made
		if [ -d "$dir" ] && [ ! -L "$dir" ] && [ "$(stat -c %u "$dir")" = "$(id -u)" ]; then
			chmod 0700 "$dir"
			export XDG_RUNTIME_DIR="$dir"
		else
			echo "Not starting dwl: $dir is not a directory owned by you." >&2
		fi
	fi
	if [ -n "${XDG_RUNTIME_DIR:-}" ]; then
		# systemd's user bus already runs (NixOS); otherwise start a session bus
		[ -S "$XDG_RUNTIME_DIR/bus" ] && exec "$HOME/.local/bin/dwl-session"
		exec dbus-run-session -- "$HOME/.local/bin/dwl-session"
	fi
fi
