{ pkgs, ... }:
{
  users.users.sko = {
    isNormalUser = true;
    description = "Sko";
    uid = 1000;
    shell = pkgs.nushell;
    group = "sko";
    extraGroups = [ "networkmanager" "dialout" "docker" "wheel" "disk" "video" "render" "storage" ];
  };
  users.groups.sko = {
    gid = 980;
  };
  systemd.tmpfiles.rules = [
    "Z /etc/nixos - sko root -"
  ];
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "org.freedesktop.udisks2.filesystem-mount-system" &&
          subject.isInGroup("storage")) {
        return polkit.Result.YES;
      }
    });
  '';
}
