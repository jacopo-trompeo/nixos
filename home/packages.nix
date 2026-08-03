{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # browser / comms
    brave # extensions-by-id possible via managed policy for a fully reproducible brave
    vesktop
    slack

    # privacy / cloud
    filen-desktop
    proton-pass
    proton-vpn
    rclone

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

    # neovim: formatters (conform) + treesitter cli; LSP servers via Mason
    stylua
    nixfmt
    shfmt
    ruff
    prettierd
    biome
    tree-sitter

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
