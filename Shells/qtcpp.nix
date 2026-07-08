{pkgs ? import <nixpkgs> {}}: let
  qt = pkgs.qt6;
in
  pkgs.mkShell {
    name = "musescore-dev-shell";

    nativeBuildInputs = with pkgs; [
      cmake
      ninja
      pkg-config
      python3
      gcc
      clang

      # Qt tools (provides qmake6)
      qt.qtbase
      qt.qttools
      qt.qtdeclarative
      qt.qtsvg
      qt.qtwayland
      qt.qt5compat
      qt.qtnetworkauth

      xxd
    ];

    buildInputs = with pkgs; [
      # Audio
      alsa-lib
      libpulseaudio
      libjack2
      libsndfile
      libremidi

      # Graphics / fonts
      freetype
      fontconfig
      harfbuzz
      icu
      expat
      libGL
      libGLU
      libxkbcommon

      # Image formats
      libjpeg
      libpng
      libwebp
    ];

    # Make sure Qt tools are discoverable
    shellHook = ''
      export QT_PLUGIN_PATH=${qt.qtbase}/${qt.qtbase.qtPluginPrefix}
      export QML2_IMPORT_PATH=${qt.qtdeclarative}/lib/qt-6/qml
    '';
  }
