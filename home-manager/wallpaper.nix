{self, ...}: {
  services.hyprpaper.enable = true;
  services.hyprpaper.settings = {
    ipc = "on";
    splash = false;
    splash_offset = 2;
    preload = [
      "/home/alex/Pictures/Wallpapers/castle-gruv.png"
      "/home/alex/Pictures/Wallpapers/a_view_of_a_city_from_a_window.jpg"
      "/home/alex/Pictures/Wallpapers/a_street_with_buildings_and_trees.png"
    ];
    wallpaper = [
      {
        monitor = "DP-1";
        path = "/home/alex/Pictures/Wallpapers/a_view_of_a_city_from_a_window.jpg";
      }
      {
        monitor = "HDMI-A-1";
        path = "/home/alex/Pictures/Wallpapers/a_street_with_buildings_and_trees.png";
      }
      {
        monitor = "HDMI-A-2";
        path = "/home/alex/Pictures/Wallpapers/castle-gruv.png";
      }
    ];
  };
}
