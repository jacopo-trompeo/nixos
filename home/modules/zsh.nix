{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      rb = "nh os switch";
      rbu = "nh os switch -u";
      ls = "eza -lh --group-directories-first --icons=auto";
      lsa = "ls -la";
      lt = "eza --tree --level=2 --long --icons --git";
      lta = "lt -a";
      ff = "fzf --preview 'bat --style=numbers --color=always {}'";
      cd = "z";
      cat = "bat";
    };

    initContent = lib.mkMerge [ ''
      try() {
        if [ $# -eq 0 ]; then
          echo "usage: try <pkg> [pkg...]   (ephemeral nix shell, nothing installed)" >&2
          return 1
        fi
        local specs=()
        local p
        for p in "$@"; do specs+=("nixpkgs#$p"); done
        nix shell "''${specs[@]}"
      }

      update() {
        echo "==> nix packages"
        (cd ~/nixos && nh os switch -u)
        echo "==> firmware"
        fwupdmgr refresh && fwupdmgr update
        echo "==> done"
      }

      cleanup-game-saves() {
        echo "==> Ren'Py"
        rm -rf ~/.renpy/* 2>/dev/null
        echo "==> Unity"
        rm -rf ~/.config/unity3d/* 2>/dev/null
        rm -rf ~/.local/share/unity3d/* 2>/dev/null
        echo "==> Godot"
        rm -rf ~/.local/share/godot/* 2>/dev/null
      }
    ''
      (lib.mkAfter ''
        eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"
      '')
    ];

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";
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
