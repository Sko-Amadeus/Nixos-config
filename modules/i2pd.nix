{ ... }:
{
  # =====================================================
  # i2pd — C++ I2P router (lightweight, no Java)
  # =====================================================
  # Web console:  http://localhost:7070
  # HTTP proxy:   localhost:4444   (configure in browser)
  # SOCKS proxy:  localhost:4447   (for non-HTTP traffic)
  # SAM bridge:   localhost:7656   (for I2P-aware apps)
  #
  # First run: wait ~15 min for tunnels to be built
  # before trying to reach .i2p sites.
  # =====================================================

  services.i2pd = {
    enable = true;

    # ── Bandwidth ───────────────────────────────────────
    # KBps; remove or raise if you want to relay more traffic
    bandwidth = 1024;

    # ── Protocols ───────────────────────────────────────
    proto = {
      # HTTP proxy — point browser to localhost:4444
      httpProxy = {
        enable   = true;
        port     = 4444;
        address  = "127.0.0.1";
      };

      # SOCKS5 proxy — for non-HTTP I2P traffic
      socksProxy = {
        enable   = true;
        port     = 4447;
        address  = "127.0.0.1";
      };

      # SAM bridge — needed for I2P-native apps (e.g. qBittorrent I2P mode)
      sam = {
        enable  = true;
        port    = 7656;
        address = "127.0.0.1";
      };

      # Web console — stats / tunnel info
      http = {
        enable   = true;
        port     = 7070;
        address  = "127.0.0.1";
      };
    };
  };

  # Only expose transit port externally; proxy/console stay localhost-only
  networking.firewall.allowedUDPPorts = [ 4433 ];  # SSU2 transit
  networking.firewall.allowedTCPPorts = [ 4433 ];  # NTCP2 transit
}
