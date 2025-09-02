{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  Mod = "SUPER";
  terminal = "alacritty";
  file_manager = "dolphin";
  browser = "zen";
in {
  programs.hyprland = {
    enable = true;
    # nvidiaPatches = true; # old not used
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = 1;
    NIXOS_OZONE_WL = 1;
    XCURSOR_THEME = "Bibita-Modern-Amber";
    XCURSOR_SIZE = 24;
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    WLR_RENDER_DRM_DEVICE = "/dev/dri/card1";
  };

  hardware = {
    graphics.enable = true;
    nvidia.modesetting.enable = true;
  };

  environment.variables = {
    HYPRSHOT_DIR = "/home/alex/Pictures/Screenshots";
  };

  environment.systemPackages = with pkgs; [
    waybar
    dunst
    libnotify
    hyprpaper
    rofi-wayland
    hypridle
    hyprlock
    hyprcursor
    hyprshot
    # pkgs.eww
    # xdg-desktop-portal
    # xdg-desktop-portal-wlr
    # xdg-desktop-portal-gtk
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      # pkgs.xdg-desktop-portal-gtk
    ];
  };

  # sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
