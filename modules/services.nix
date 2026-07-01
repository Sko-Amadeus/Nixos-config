{ ... }:
{
  services = {
    printing.enable = true;
    xserver.wacom.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
    resilio.enable = true;
    flatpak.enable = true;
    tumbler.enable = true;
  };

  services.udev.extraRules = ''
    # TI-84 Plus CE / CE-T USB
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0451", ATTRS{idProduct}=="e008", MODE="0666", GROUP="users"
  '';
}
