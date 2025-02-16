{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "vishwa";
  home.homeDirectory = "/home/vishwa";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; 
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    flutter
    unityhub
    chrome-gnome-shell
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  imports = [
    ./../../modules/home-manager/default.nix
  ];
}
