{ ... }:

{
  services.displayManager.ly.enable = true;
  services.upower.enable = true;
  services.tailscale.enable = true;
  services.tailscale.extraSetFlags = [ "--operator=jacopo" ];
  services.fwupd.enable = true;
  services.gvfs.enable = true;
  services.fstrim.enable = true;
}
