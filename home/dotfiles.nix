{ config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos/home/dotfiles";

  apps = [
    "niri"
    "ghostty"
    "nvim"
    "zed"
    "abcde"
    "rmpc"
    "tmux"
    "noctalia"
  ];
in

{
  xdg.configFile = builtins.listToAttrs (map (app: {
    name = app;
    value = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${app}";
    };
  }) apps) // {
    "BraveSoftware/startpage" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/brave-startpage";
    };
  };
}
