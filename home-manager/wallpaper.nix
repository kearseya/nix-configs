{self, ...}: {
  services.hyprpaper.enable = true;
  services.hyprpaper.settings = {
    ipc = "on";
    splash = false;
    splash_offset = 2.0;
    preload = ["/home/alex/Pictures/Wallpapers/castle-gruv.png"];
    wallpaper = [
      "DP-1,/home/alex/Pictures/Wallpapers/castle-gruv.png"
      "HDMI-A-1,/home/alex/Pictures/Wallpapers/castle-gruv.png"
      "HDMI-A-2,/home/alex/Pictures/Wallpapers/castle-gruv.png"
    ];
  };
}
