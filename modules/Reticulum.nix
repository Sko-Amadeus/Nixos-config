{
  services.rnsd = {
    enable = true;
    settings = {
      reticulum = {
        enable_transport = true;
        share_instance = true;
        rpc_key = "647391e2def98ad3a744507879ec9cb8a3e2cf5f219b9bf327f5cfb8d456c081";
        instance_name = "default";
        shared_instance_type = "tcp";
        shared_instance_port = 37428;
        instance_control_port = 37429;
      };
      interfaces = {
        auto = {
          type = "AutoInterface";
          enabled = true;
          devices = "enp6s0";                        # only use your real NIC
          ignored_devices = "docker0, veth*, br-*";   # belt-and-suspenders
          internet = {
         type = "TCPClientInterface";
         enabled = true;
         target_host = "reticulum.network";
         target_port = 4242;
          };
        };

      };
    };
    # No transportIdentityFile/identities set: rnsd will generate its own
    # identity under $STATE_DIRECTORY/storage on first start. Back it up
    # from /var/lib/rnsd/storage/transport_identity once created if you
    # want to pin it via this option later (e.g. via sops-nix).
    extraGroups = [ "dialout" ];

    # Uses the module's built-in firewall rule generator rather than a
    # manual allowedUDPPorts list.
    # NOTE: this module currently hardcodes UDP 27916 — upstream Reticulum
    # docs say AutoInterface discovery uses 29716. This looks like a
    # possible transposition bug in the PR; worth flagging to the author
    # before merge. Until confirmed/fixed, you may need both ports open:
    openMulticastPorts = true;
  };

  services.lxmd = {
    enable = true;
    settings = {
      propagation-node = {
        autopeer = true;
      };
    };
    # No identityFile set: lxmd will generate its own LXMF identity under
    # $STATE_DIRECTORY/lxmd on first start.
    rnsd = {
      settings = {
        reticulum = {
          rpc_key ="647391e2def98ad3a744507879ec9cb8a3e2cf5f219b9bf327f5cfb8d456c081";
          is_shared_instance = true;
          shared_instance_type = "tcp";
          shared_instance_port = 37428;
          instance_control_port = 37429;
        };
        # No [[interfaces]] here: this is lxmd's private, embedded RNS
        # instance acting purely as a shared-instance TCP client of the
        # system rnsd service above — it doesn't manage any interfaces
        # or act as a transport node itself, so no transportIdentityFile
        # is needed either.
      };
    };
  };

  # Possible port-name mismatch — see note on openMulticastPorts above.
  # Uncomment if 27916 alone doesn't get AutoInterface discovery working:
  # networking.firewall.allowedUDPPorts = [ 29716 42671 ];

  # Loopback shared-instance traffic (37428/37429) doesn't need to cross
  # the firewall — lo is already accepted unconditionally. Only open
  # these if something external needs to reach the shared instance
  # directly.
  networking.firewall.allowedTCPPorts = [ 37428 37429 ];
}
