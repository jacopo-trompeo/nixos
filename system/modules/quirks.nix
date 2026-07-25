{ pkgs, ... }:

{
  # 8BitDo Pro 2 wired: the controller firmware resets the USB device unless the
  # evdev node is kept open. Covers both X-input (2dc8:3106) and D-input (2dc8:3010).
  services.udev.extraRules = ''
    ### 8BitDo Pro 2 Wired (X-input mode) ###
    SUBSYSTEM=="usb", ATTR{idVendor}=="2dc8", ATTR{idProduct}=="3106", ENV{MTP_NO_PROBE}="1"
    ACTION=="add", SUBSYSTEM=="input", ATTRS{idVendor}=="2dc8", ATTRS{idProduct}=="3106", TAG+="systemd", ENV{SYSTEMD_WANTS}="evdev-keepalive@$kernel.service"
    ### 8BitDo Pro 2 Wired (D-input mode, post-reboot default) ###
    SUBSYSTEM=="usb", ATTR{idVendor}=="2dc8", ATTR{idProduct}=="3010", ENV{MTP_NO_PROBE}="1"
    ACTION=="add", KERNEL=="event[0-9]*", SUBSYSTEM=="input", ATTRS{idVendor}=="2dc8", ATTRS{idProduct}=="3010", TAG+="systemd", ENV{SYSTEMD_WANTS}="evdev-keepalive@$kernel.service"
  '';

  # Pure-systemd replacement for the old custom /usr/bin/evdev_keepalive binary:
  # opening the device as stdin and holding it open keeps the fd alive (same effect).
  systemd.services."evdev-keepalive@" = {
    description = "Keep evdev %i open (8BitDo Pro 2 firmware-reset workaround)";
    serviceConfig = {
      ExecStart = "${pkgs.coreutils}/bin/sleep infinity";
      StandardInput = "file:/dev/input/%i";
      StopWhenUnneeded = true;
    };
  };
}
