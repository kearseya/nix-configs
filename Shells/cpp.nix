{pkgs ? import <nixpkgs> {}}:
pkgs.stdenv.mkDerivation {
  name = "c++ dev";
  nativeBuildInputs = with pkgs; [
    gcc
    clang
    python3
    ninja
    cmake
    # qtEnv
    # alsa-utils
    # fluidsynth
    # lmms
    # helvum
  ];

  buildInputs = with pkgs; [
    pkg-config
    glfw
    skia
    clang
    gn

    expat
    fontconfig
    freetype
    harfbuzzFull
    icu
    libGL

    glm
    openal
    kissfft
    libsndfile
    # opencl-headers

    libjpeg
    libwebp

    libremidi
    alsa-lib
    libpulseaudio
    libjack2
  ];

  LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath [pkgs.glfw pkgs.skia pkgs.libGL]}";
  # fonts = {
  #   packages = with pkgs; [
  #     (nerdfonts.override {fonts = ["Helvetica"];})
  #   ];
  # };
}
