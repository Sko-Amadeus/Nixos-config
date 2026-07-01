#!/usr/bin/env bash
set -e

nix-shell -p autoconf automake libtool pkg-config gtk3 libusb1 glib git intltool \
  --run '
    set -e
    cd /tmp

    # Clean previous attempts
    rm -rf tilibs tilp_and_gfm

    git clone https://github.com/debrouxl/tilibs.git
    cd tilibs

    for lib in libticonv libtifiles2 libticables2 libticalcs2; do
      echo "=== Building $lib ==="
      cd $lib
      autoreconf -i
      ./configure
      make
      sudo make install
      cd ..
    done

    sudo ldconfig

    cd /tmp
    git clone https://github.com/debrouxl/tilp_and_gfm.git
    cd tilp_and_gfm/tilp
    autoreconf -i
    ./configure
    make
    sudo make install
  '
