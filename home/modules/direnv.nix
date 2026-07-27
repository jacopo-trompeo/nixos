{ ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = false;
  };

  xdg.configFile."direnv/direnv.toml".text = ''
    hide_env_diff = true
  '';
}
