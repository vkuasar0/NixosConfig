{ config, pkgs, ...} :
{
  home.file.".config/rofi" = {
    source = ./dotfiles/rofi;
    recursive = true;
  };
}
