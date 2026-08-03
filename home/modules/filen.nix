{ pkgs, ... }:

{
  systemd.user.services.filen-mount = {
    Unit.Description = "Mount Filen (rclone)";
    Install.WantedBy = [ "default.target" ];
    Service = {
      Type = "notify";
      Environment = "PATH=/run/wrappers/bin:${pkgs.fuse3}/bin";
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/Filen";
      ExecStart = "${pkgs.rclone}/bin/rclone mount filen: %h/Filen --vfs-cache-mode writes --dir-cache-time 1m";
      ExecStop = "/run/wrappers/bin/fusermount3 -u %h/Filen";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };
}
