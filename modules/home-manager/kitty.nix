{ config, pkgs, ... }:
{
  home.file.".config/kitty/kitty.conf".source = ./dotfiles/kitty/kitty.conf;
  home.file.".config/kitty/kitty-colors.conf".source = ./dotfiles/kitty/kitty-colors.conf;
}
