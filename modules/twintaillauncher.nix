{ pkgs, ... }:

let
  twintail-deb = pkgs.fetchurl {
    url = "https://github.com/TwintailTeam/TwintailLauncher/releases/download/ttl-v1.1.15/twintaillauncher_1.1.15_amd64.deb";
    sha256 = "64983405b296728718f31504ac4d1a0e003b4ce93ca6705f4092c71421fceab0";
  };

  twintaillauncher = pkgs.stdenv.mkDerivation {
    pname = "twintaillauncher";
    version = "1.1.15";
    src = twintail-deb;

    nativeBuildInputs = [ pkgs.dpkg pkgs.autoPatchelfHook pkgs.makeWrapper ];

    buildInputs = with pkgs; [
      webkitgtk_4_1
      gtk3
      glib
      openssl
      libayatana-appindicator
      dbus
      librsvg
      gdk-pixbuf
      pango
      cairo
      atk
      libx11
      libxext
      libxcb
      libsoup_3
      curl
    ];

    unpackPhase = "dpkg-deb -x $src .";

    installPhase = ''
      mkdir -p $out
      cp -r usr/bin $out/bin
      cp -r usr/share $out/share
    '';

   postFixup = ''
  wrapProgram $out/bin/twintaillauncher --prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath (with pkgs; [ libayatana-appindicator ])} --set WEBKIT_DISABLE_DMABUF_RENDERER 1 --set WEBKIT_DISABLE_COMPOSITING_MODE 1 --set __GL_THREADED_OPTIMIZATIONS 0 --set __NV_DISABLE_EXPLICIT_SYNC 1 --set GDK_RENDERING_MODE cairo --set WGPU_BACKEND gl
'';

  };
in
{
  environment.systemPackages = [ twintaillauncher ];
}
