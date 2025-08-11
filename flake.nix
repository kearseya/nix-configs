{
  description = "alex's flake";

  inputs = {
    # System
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
      # useUserPackages = true;
      # useGlobalPkgs = true;
      # backupFileExtention = "backup";
    };

    # Themeing
    nix-colors = {
      url = "github:misterio77/nix-colors";
      # nix-colors.inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # stylix = {
    #   url = "github:/danth/stylix/release-25.05";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # Programs
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    #neovim = {
    #	url = "github:nix-community/neovim-nightly-overlay";
    #	inputs.nixpkgs.follows = "nixpkgs";
    #};

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-colors,
    catppuccin,
    zen-browser,
    nvf,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      nixos-desktop = lib.nixosSystem {
        inherit system;
        #extraArgs.inputs = inputs;
        specialArgs = {
          host = "desktop";
          inherit self inputs;
        };
        modules = [
          hosts/desktop/configuration.nix
          # inputs.stylix.nixosModules.stylix
        ];
      };
    };

    homeConfigurations = {
      alex = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          host = "desktop";
          inherit self inputs;
        };
        modules = [
          home-manager/home.nix
          inputs.nvf.homeManagerModules.default
          # inputs.stylix.homeModules.stylix
        ];
      };
    };
  };
}
