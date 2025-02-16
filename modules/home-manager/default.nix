{ config, pkgs, ...}: {
  imports = [
    ./kitty.nix
    ./rofi.nix
    ./hyprland.nix
    ./neovim.nix
    ./mako.nix
    ./chromium.nix
    ./git.nix
  ];
}
