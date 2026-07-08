{self, ...}: {
  services.hyprpaper.enable = true;
  services.hyprpaper.settings = {
    ipc = "on";
    splash = false;
    splash_offset = 2.0;
    preload = [
      "/home/alex/Pictures/Wallpapers/castle-gruv.png"
      "/home/alex/Pictures/Wallpapers/a_view_of_a_city_from_a_window.jpg"
      "/home/alex/Pictures/Wallpapers/a_street_with_buildings_and_trees.png"
    ];
    wallpaper = [
      "DP-1,/home/alex/Pictures/Wallpapers/a_view_of_a_city_from_a_window.jpg"
      "HDMI-A-1,/home/alex/Pictures/Wallpapers/a_street_with_buildings_and_trees.png"
      "HDMI-A-2,/home/alex/Pictures/Wallpapers/castle-gruv.png"
    ];
  };
}
