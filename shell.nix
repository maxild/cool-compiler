let
  pkgs = import <nixpkgs> { system = "i686-linux"; };

  #libcPath = makeLibraryPath
  libcPath = "${pkgs.stdenv.cc.libc}/lib";
in
  pkgs.mkShell {
    name = "cs143-class";

    nativeBuildInputs = [
      pkgs.patchelf
    ];

    buildInputs = [
      pkgs.gcc
      pkgs.gnumake
      pkgs.flex
      pkgs.bison
    ];

    shellHook = ''
      export PATH="$PATH:$PWD/bin"
      #export LD_LIBRARY_PATH=${libcPath}
      # run SPIM with 32-bit ELF interpreter from the nix store
      interp="$(patchelf --print-interpreter $PWD/bin/.i686/spim)"
      if [[ ! ($interp =~ ^/nix/store) ]]; then
        patchelf --set-interpreter ${libcPath}/ld-linux.so.2 \
                 --set-rpath ${libcPath} \
                 $PWD/bin/.i686/spim
      fi
    '';

  }
