{ ... }:

{
  services.syncthing = {
    enable = true;
    user = "jacopo";
    group = "users";
    configDir = "/home/jacopo/.config/syncthing";
    dataDir = "/home/jacopo/.local/share/syncthing";
    guiAddress = "127.0.0.1:8384";
    openDefaultPorts = true;
    overrideDevices = false;
    overrideFolders = false;
  };
}
