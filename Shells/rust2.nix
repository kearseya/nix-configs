{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    rustup
    pkg-config

    # X11
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
    xorg.libXxf86vm
    xorg.libXinerama

    # Wayland
    wayland
    wayland-protocols
    wayland-scanner
    libxkbcommon
    egl-wayland

    # Vulkan
    vulkan-loader
    vulkan-headers
    vulkan-validation-layers

    # OpenGL / Mesa
    mesa
    mesa.drivers
    libGL

    # Audio
    fluidsynth
  ];

  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (with pkgs; [
    # X11
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
    xorg.libXxf86vm
    xorg.libXinerama

    # Wayland
    wayland
    libxkbcommon
    egl-wayland

    # Vulkan
    vulkan-loader

    # OpenGL / Mesa
    mesa
    mesa.drivers
    libGL
  ]);

  LIBGL_DRIVERS_PATH = "${pkgs.mesa.drivers}/lib/dri";
  EGL_PLATFORM       = "wayland";

  shellHook = ''
    # Use system GPU drivers if available (NixOS puts real hardware drivers here)
    if [ -d /run/opengl-driver/lib ]; then
      export LD_LIBRARY_PATH="/run/opengl-driver/lib:$LD_LIBRARY_PATH"
    fi

    # Build VK_ICD_FILENAMES from system ICDs + lavapipe software fallback
    SYSTEM_ICDS=""
    if [ -d /run/opengl-driver/share/vulkan/icd.d ]; then
      SYSTEM_ICDS=$(find /run/opengl-driver/share/vulkan/icd.d -name "*.json" | tr '\n' ':')
    fi
    LAVAPIPE="${pkgs.mesa.drivers}/share/vulkan/icd.d/lvp_icd.x86_64.json"
    export VK_ICD_FILENAMES="''${SYSTEM_ICDS}''${LAVAPIPE}"
  '';
}
