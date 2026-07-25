{ pkgs, ... }:

{
  users = {
    defaultUserShell = pkgs.zsh;

    users.jacopo = {
      isNormalUser = true;
      description = "Jacopo";
      extraGroups = [ "wheel" "networkmanager" "input" "docker" ];
    };
  };
}
