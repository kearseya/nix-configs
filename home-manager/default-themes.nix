{pkgs, ...}: {
  qt = {
    enable = true;
    platformTheme.name = "qtk";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "peach";
      };
    };
    # iconTheme = {
    #   #name = "Catppuccin-Mocha-Blue";
    #   name = "Catppuccin-Mocha-Standard-Blue-Dark";
    #   package = pkgs.catppuccin-papirus-folders.override {
    #     flavor = "mocha";
    #     accent = "blue";
    #   };
    # };
    # iconTheme = {
    #   name = "Gruvbox-Plus-Dark";
    #   package = pkgs.gruvbox-plus-icons;
    # };
  };
}
