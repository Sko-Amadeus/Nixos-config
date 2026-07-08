{
  services.rnsd = {
    enable = true;
    settings = {
      reticulum = {
        enable_transport = true;
        share_instance = true;
        instance_name = "default";
        shared_instance_type = "unix";
      };
      interfaces = {
        auto = {
          type = "AutoInterface";
          enabled = true;
        };
      };
    };
    transportIdentityFile = "<path-to-transport-identify-file>";
    extraGroups = [ "dialout" ];
  };

  services.lxmd = {
    enable = true;
    settings = {
      propagation-node = {
        autopeer = true;
      };
    };

    rnsd = {
      settings = {
        reticulum = {
          is_shared_instance = true;
          enable_transport = true;
          instance_name = "default";
          shared_instance_type = "unix";
        };
        interfaces = {
          auto = {
            type = "AutoInterface";
            enabled = true;
          };
        };
      };
      transportIdentifyFile = "<path-to-transport-identity-file>";
    };
    identityFile = "<path-to-identity-file>";
  };

  networking.firewall.allowedTCPPorts = [
    4242
  ];
}
