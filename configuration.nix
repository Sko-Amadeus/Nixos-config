{ config, pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/podman.nix
    ./modules/i2pd.nix
    ./modules/hyphanet.nix
    ./modules/ollama.nix
    ./modules/kde.nix
    ./modules/cloudflared-delay.nix
    ./modules/bluetooth.nix
    ./modules/filesystems.nix
    ./modules/users.nix
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/locale.nix
    ./modules/nvidia.nix
    ./modules/desktop.nix
    ./modules/audio.nix
    ./modules/nushell.nix
    ./modules/docker.nix
    ./modules/services.nix
    ./modules/gaming.nix
    ./modules/twintaillauncher.nix
    ./modules/jellyfin.nix
    ./modules/packages.nix
    ./modules/star-citizen.nix
    ./modules/hyprland.nix
    ./modules/ssh.nix
    ./modules/sops.nix

  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.settings.auto-optimise-store = true;

  system.stateVersion = "25.11";
}
