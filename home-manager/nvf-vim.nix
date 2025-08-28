{
  self,
  pkgs,
  lib,
  ...
}: {
  # programs.vim = {
  #   enable = true;
  #   extraConfig = ''
  #     set tabstop=2
  #     set noexpandtab
  #     set shiftwidth=2
  #     set number relativenumber
  #     set autoindent
  #     set tabwidth=2
  #     set mouse=a
  #     set clipboard=unnamedplus
  #     vnoremap <C-C> "+y
  #   '';
  # };

  # programs.neovim = {
  #   enable = true;
  #
  #   # Ensure plugins actually get loaded:
  #   extraLuaConfig = ""; # A blank string suffices.
  #
  #   plugins = with pkgs.vimPlugins; [
  #     {
  #       # plugin = sphamba-smear-cursor-nvim;
  #       pkgs.vimUtils.buildVimPlugin {
  #         src = pkgs.fetchFromGitHub {
  #           owner = "sphamba";
  #           repo = "smear-cursor.nvim";
  #         };
  #       }
  #       type = "lua"; # Ensures config is treated as Lua code
  #       config = ''
  #         require("smear").setup()
  #       '';
  #     }
  #   ];
  # };
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;

        tabline.nvimBufferline.enable = true;

        spellcheck.enable = true;
        lsp = {
          enable = true;
          formatOnSave = true;
        };

        terminal = {
          toggleterm = {
            enable = true;
          };
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          illuminate.enable = true;
        };

        debugger = {
          nvim-dap = {
            enable = true;
            ui.enable = true;
          };
        };

        languages = {
          enableFormat = true;
          enableTreesitter = true;

          nix.enable = true;
          markdown.enable = true;
          python.enable = true;
          bash.enable = true;
          lua.enable = true;
          clang.enable = true;
          #css.enable = true;
          html.enable = true;

          #java.enable = true;
          #kotlin.enable = true;
          go.enable = true;
        };

        visuals = {
          nvim-scrollbar.enable = true;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          highlight-undo.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "gruvbox";
          };
        };

        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
          transparent = false;
        };

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false;
        };

        utility = {
          surround.enable = true;
          multicursors.enable = true;
          motion = {
            hop.enable = true;
            leap.enable = true;
          };
        };
        # most plugins
        telescope.enable = true;
        comments.comment-nvim.enable = true;
      };
    };
  };
}
