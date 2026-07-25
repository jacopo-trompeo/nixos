{ pkgs, ... }:

{
  home.packages = [
    (pkgs.bottles.override { removeWarningPopup = true; })

    (pkgs.writeShellScriptBin "bottles-launch" ''
      bottles & wait
    '')

    (pkgs.writeShellScriptBin "vn" (builtins.readFile ../scripts/vn.sh))

    (pkgs.writeShellScriptBin "vn-list"
      "exec ${pkgs.python3.withPackages (ps: [ ps.pyyaml ])}/bin/python3 ${../scripts/vn-list.py}")
  ];

  xdg.desktopEntries."com.usebottles.bottles" = {
    name = "Bottles";
    genericName = "Wine Prefix Manager";
    comment = "Run Windows software";
    exec = "bottles-launch";
    icon = "com.usebottles.bottles";
    terminal = false;
    type = "Application";
    categories = [ "Utility" ];
    startupNotify = true;
    settings.StartupWMClass = "com.usebottles.bottles";
  };
}
