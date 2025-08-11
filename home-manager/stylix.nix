{pkgs, ...}: {
  stylix = {
    enable = true;
    # autoEnable = true;
    base16Scheme = pkgs.lib.mkDefault "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    # image = "~/Pictures/Wallpapers/castle-gruv.png";
    # polarity = "dark";
    targets = {
      gtk.enable = true;
      gnome.enable = true;
      qt.enable = true;
      # grub.enable = true;
    };
  };
}
