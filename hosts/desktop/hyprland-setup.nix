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
    XCURSOR_THEME = "breeze";
    XCURSOR_SIZE = 24;
  };

  hardware = {
    graphics.enable = true;
    nvidia.modesetting.enable = true;
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
    # pkgs.eww
  ];

  # xdg.portal = true;
  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-hyprland];

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
