{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    rustup
    # rustc
    # cargo
    # Required by winit on Linux
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
    xorg.libXxf86vm
    xorg.libXinerama
    wayland
    libxkbcommon
    pkg-config
    # OpenGL
    mesa
    libGL
    fluidsynth
  ];
  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
    pkgs.xorg.libX11
    pkgs.xorg.libXcursor
    pkgs.xorg.libXrandr
    pkgs.xorg.libXi
    pkgs.xorg.libXxf86vm
    pkgs.xorg.libXinerama
    pkgs.wayland
    pkgs.libxkbcommon
    # OpenGL
    pkgs.mesa
    pkgs.libGL
  ];
}
