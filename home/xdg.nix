{ lib, ... }:

{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    desktop = null;
    publicShare = null;
    templates = null;
  };

  home.activation.customDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run mkdir -p \
      "$HOME/Projects" \
      "$HOME/Work" \
      "$HOME/Pictures/screenshots" \
      "$HOME/Pictures/wallpapers" \
      "$HOME/Videos/screenrecords"
  '';

}
