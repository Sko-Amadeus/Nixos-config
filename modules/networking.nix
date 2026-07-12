{ ... }:
{
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      dns = "dnsmasq";
    };
  };

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
  };

  systemd.services.NetworkManager = {
    serviceConfig = {
      AmbientCapabilities = [
        "CAP_CHOWN"
        "CAP_NET_ADMIN"
        "CAP_NET_RAW"
        "CAP_SYS_MODULE"
      ];
      CapabilityBoundingSet = [
        "CAP_CHOWN"
        "CAP_NET_ADMIN"
        "CAP_NET_RAW"
        "CAP_SYS_MODULE"
      ];
    };
  };
}
