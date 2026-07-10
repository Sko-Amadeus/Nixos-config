{ pkgs, inputs, ... }:

{
      programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [

    # =========================
    # Development & CLI
    # =========================
    git
    vencord
    wget
    neovim
    ripgrep
    fd
    bat
    eza
    zoxide
    xh
    hyperfine
    delta
    fetchtastic
    ripgrep-all
    just
    dust
    esptool
    mold
    dua
    rustc
    gearlever
    nil
    freerdp
    rustup
    r2modman
    deno
    # Shells
    fish
    nushell
    starship
    gcc

    # Terminal
    zellij
    gitui
    yazi
    lazydocker
    kitty
    wiki-tui
    kitty-img
    kitty-themes
    wiremix

    # =========================
    # Gaming & Tools
    # =========================
    mangohud
    protonup-ng

    # =========================
    # Docker & System
    # =========================
    docker
    docker-client
    tailscale
    polkit_gnome
    ntfs3g
    exfat

    # =========================
    # Media & Apps
    # =========================
    element-desktop
    obsidian
    mpc
    mpd
    ffmpeg
    rmpc
    jellyfin-media-player
    spotdl
    ncspot
    librespot
    youtube-tui
    playerctl

    # =========================
    # Utilities
    # =========================
    wl-clipboard
    cliphist
    p7zip
    fastfetch
    sops
    bazaar
    bluetui
    tdf
    plasticity
    inetutils
    zssh
    fast-ssh
    ircdog
    python315
    pipx
    qmk
    qmk-udev-rules
    qpdf
    exiftool
    pdfcrack
    contact
    python314Packages.nomadnet
    #python313Packages.lxmf
     rns
    # =========================
    # Optional / Advanced
    # =========================
    espanso-wayland
    jetbrains-toolbox
    presenterm
    kondo
    mprocs
    mask
    cargo-info
    bacon
    resilio-sync
    evil-helix

    # =========================
    # Fonts
    # =========================
    pkgs.nerd-fonts.jetbrains-mono

    # =========================
    # Custom packages
    # =========================
    (pkgs.buildGoModule rec {
      pname = "surge";
      version = "0.7.0";
      src = pkgs.fetchFromGitHub {
        owner = "surge-downloader";
        repo = "surge";
        rev = "v${version}";
        hash = "sha256-0rgD9tMt3P/Bme39WleIdQQFOzU1RlG8H43bVNjkC50=";
      };
      vendorHash = "sha256-XIXH/d4Fjk3KFFQn+MfRGiAgR48KGvWoh1PuNb3yryg=";
      doCheck = false;
    })

    inputs.twintail-launcher.packages.${pkgs.system}.default

  ];
}
