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
  networking.firewall.enable = true;

  zramSwap.enable = true;

  time.timeZone = "Europe/Rome";

  i18n.extraLocaleSettings = {
    LC_TIME = "it_IT.UTF-8";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05";
}
