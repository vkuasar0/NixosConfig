{ config, pkgs, ... }:
{
  home.file.".config/hypr" = {
    source = ./dotfiles/hypr;
    recursive = true;
  };
}
