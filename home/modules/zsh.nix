{ config, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    initContent = lib.mkAfter ''
      source "${config.xdg.configHome}/zsh/rc.zsh"
    '';
  };

  programs.starship.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = false;
  };
  programs.fzf.enable = true;
  programs.eza.enable = true;
  programs.bat.enable = true;
}
