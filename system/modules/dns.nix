{ ... }:

{
  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSOverTLS = "true";
      DNSSEC = "allow-downgrade";
      Domains = "~.";
    };
  };

  networking.nameservers = [
    "194.242.2.2#dns.mullvad.net"
    "2a07:e340::2#dns.mullvad.net"
  ];

  networking.networkmanager.dns = "systemd-resolved";
}
