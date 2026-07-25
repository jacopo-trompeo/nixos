{ ... }:

{
  environment.etc."brave/policies/managed/nixos.json".text = builtins.toJSON {
    HomepageLocation = "file:///home/jacopo/.config/BraveSoftware/startpage/index.html";
    HomepageIsNewTabPage = false;
    ShowHomeButton = false;
    RestoreOnStartup = 4;
    RestoreOnStartupURLs = [ "file:///home/jacopo/.config/BraveSoftware/startpage/index.html" ];
  };
}
