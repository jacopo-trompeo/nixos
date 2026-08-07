{ pkgs, ... }:

{
  # CUPS with HP's HPLIP driver suite. hplipWithPlugin bundles the proprietary
  # binary plugin some HP models require (allowUnfree is already set).
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
  };

  # mDNS so network printers (and scanners) are auto-discovered.
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # HP Smart Tank 7000 (all-in-one) on the LAN, added declaratively with its
  # model-specific hpcups driver. A4 to match the local default.
  hardware.printers = {
    ensureDefaultPrinter = "HP_Smart_Tank_7000";
    ensurePrinters = [
      {
        name = "HP_Smart_Tank_7000";
        location = "Home";
        deviceUri = "ipp://192.168.178.23/ipp/print";
        model = "drv:///hp/hpcups.drv/hp-smart_tank_7000_series.ppd";
        ppdOptions.PageSize = "A4";
      }
    ];
  };
}
