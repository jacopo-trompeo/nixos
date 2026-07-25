{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./users.nix
      ./packages.nix
      ./services.nix
      ./modules/bundle.nix
    ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 5;
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Rome";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05";
}
