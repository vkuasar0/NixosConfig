{ config, lib, pkgs, ... }:
{
  powerManagement.enable = true;
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchDocked = "ignore";
    extraConfig = ''
      HandlePowerKey = suspend
    '';
  };
}
