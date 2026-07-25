{ pkgs, ... }:

{
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.unstable.proton-ge-bin ];
  };

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
    goverlay
    protontricks
  ];
}
