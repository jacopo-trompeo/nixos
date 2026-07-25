{ ... }:

{
  programs.nh = {
    enable = true;
    flake = "/home/jacopo/nixos";
    clean = {
      enable = true;
      extraArgs = "--keep 5 --keep-since 14d";
    };
  };

  nix.optimise.automatic = true;
}
