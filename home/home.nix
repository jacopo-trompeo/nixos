{  ... }:

{
  imports = [
    ./modules/bundle.nix
    ./packages.nix
    ./dotfiles.nix
    ./theme.nix
    ./xdg.nix
  ];

  home = {
    username = "jacopo";
    homeDirectory = "/home/jacopo";
    stateVersion = "26.05";
  };
}
