#!/bin/sh
# Non-Nix systems: link every file of this repository to the same path in $HOME.
# An existing file is kept as <name>.bak. NixOS does not use this script.
set -eu
repo=$(cd "$(dirname "$0")" && pwd -P)
cd "$repo"
find . -path ./.git -prune -o -type f ! -name install.sh ! -name README.md -print | while read -r f; do
	f=${f#./}
	dst="$HOME/$f"
	[ "$(readlink "$dst" 2>/dev/null)" = "$repo/$f" ] && continue
	mkdir -p "$(dirname "$dst")"
	[ -e "$dst" ] || [ -L "$dst" ] && mv "$dst" "$dst.bak"
	ln -s "$repo/$f" "$dst"
	echo "linked $f"
done
