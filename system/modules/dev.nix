{ pkgs, ... }:

{
  virtualisation.docker.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    zstd
    openssl
    curl
    expat
    icu
    fuse3
    libGL
    libgbm
    libdrm
    libxkbcommon
    vulkan-loader
    glib
    gtk3
    gdk-pixbuf
    cairo
    pango
    atk
    at-spi2-atk
    at-spi2-core
    dbus
    cups
    nss
    nspr
    alsa-lib
    libpulseaudio
    systemd
    libnotify
    libcap
    libx11
    libxcomposite
    libxdamage
    libxext
    libxfixes
    libxrandr
    libxrender
    libxtst
    libxi
    libxcursor
    libxscrnsaver
    libxcb
    libxshmfence
    libxt
    libxmu
  ];
}
