{ pkgs, ... }:
{
  # =====================================================
  # Hyphanet (formerly Freenet) — distributed datastore
  # =====================================================
  # Web interface: http://localhost:8888
  # Data dir:      /var/lib/freenet
  #
  # ⚠  KNOWN NIXPKGS BUG (as of 2026):
  #    The WebOfTrust plugin fails to load under newer JVM
  #    due to module access restrictions. Freemail and Freetalk
  #    won't work until this is fixed upstream.
  #    Ref: https://github.com/NixOS/nixpkgs/issues/438204
  #    Core browsing / publishing / FMS still works fine.
  #
  # First run: expect to leave it running for hours before
  # the datastore fills up and routing becomes reliable.
  # =====================================================

  services.freenet = {
    enable    = true;
    # Opennet mode (connect to random strangers).
    # For darknet (friends-only), connect peers manually
    # via the web interface at localhost:8888.
  };

  # Hyphanet handles its own port negotiation but the
  # default FNP (Freenet Node Protocol) port needs to be open.
  networking.firewall.allowedTCPPorts = [ 29900 ];
  networking.firewall.allowedUDPPorts = [ 29900 ];

  # Give yourself easy CLI access to the data dir
  environment.systemPackages = [ pkgs.freenet ];
}
