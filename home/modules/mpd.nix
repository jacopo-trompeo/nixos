{ config, ... }:

{
  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
    playlistDirectory = "${config.home.homeDirectory}/.config/mpd/playlists";
    network.listenAddress = "127.0.0.1";
    network.port = 6600;
    extraConfig = ''
      restore_paused "yes"
      auto_update "yes"

      audio_output {
        type "pipewire"
        name "PipeWire Sound Server"
      }
    '';
  };

  services.mpd-mpris.enable = true;

  xdg.dataFile."applications/rmpc.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=rmpc
    NoDisplay=true
  '';
}
