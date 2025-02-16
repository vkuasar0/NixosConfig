{ config, pkgs, ... }:
{
  home.file.".config/nvim" = {
    source = ./dotfiles/nvim;
    recursive = true;
  };
}
