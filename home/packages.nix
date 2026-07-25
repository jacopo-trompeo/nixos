{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # browser / comms
    brave # extensions-by-id possible via managed policy for a fully reproducible brave
    vesktop
    slack

    # terminal
    ghostty
    neovim
    tmux
    wl-clipboard

    # files / media / images
    nautilus
    eog
    mpv
    mpvpaper
    obsidian

    # audio / music
    abcde
    rmpc
    mpc
    pavucontrol

    # shell
    noctalia-shell

    # dev
    dbeaver-bin
    lazygit
    lazydocker
    zed-editor
    nodejs
    gcc
    python3
    fd
    nil
    gh

    # misc
    anki
    fastfetch
    btop
    ripgrep
    jq
    tree
    lxqt.lxqt-policykit

    # ai
    unstable.claude-code
    unstable.opencode

    # archives
    unzip
    unrar
    zip
    p7zip
    file-roller
  ];
}
