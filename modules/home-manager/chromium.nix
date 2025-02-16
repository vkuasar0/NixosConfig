{ config, pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    commandLineArgs = [
      "--enable-features=TouchpadOverscrollHistoryNavigation --disable-experiments --disable-gpu"
    ];
  };
}
