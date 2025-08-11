{pkgs}:
# let
#   imgLink = "https://gruvbox-wallpapers.pages.dev/thumbnails/pixelart/gruvbox_image40.png";
#
#   image = pkgs.fetchurl {
#     url = imgLink;
#     # sha256 = "sha256-HrcYriKliK2QN02/2vFK/osFjTT1NamhGKik3tozGU0=";
#   };
# in
# let
#   image = "~/Pictures/Wallpapers/castle-gruv.png";
# in
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-sugar-dark";
    rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
    sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
  '';
}
