# dotfiles

Configuration for the dwl desktop, usable with and without Nix.

- **NixOS** ([MJorink/NixOS](https://github.com/MJorink/NixOS)) takes this repository as a
  flake input. Programs that accept a config path are *wrapped* to read their file
  straight from here (foot, fnott, swaylock, neovim, htop, LibreWolf). The rest
  (`.profile`, `.ashrc`, `.bashrc`, `.local/bin`, `.config/dwl`, git, mimeapps)
  are linked into `$HOME` at boot. `.claude/` is linked to the checkout in
  `~/repos/dotfiles`, so Claude Code can still write its settings.
- **Other systems**: `./install.sh` links every file into `$HOME` (existing files
  are kept as `<name>.bak`).

Scripts call `systemctl` when it exists (NixOS: logind, doas rules for
`systemctl suspend|reboot|poweroff`), and the Alpine paths otherwise.
