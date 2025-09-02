{
  self,
  pkgs,
  lib,
  environment,
  ...
}: {
  # home.file."~/.config/nvim/smear.lua".text = ''
  #   -- Add smear-cursor.nvim to Lua package path
  #   for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
  #     local smear_path = path .. "/lua"
  #     package.path = package.path .. ";" .. smear_path .. "/?.lua;" .. smear_path .. "/?/init.lua"
  #   end
  #
  #   -- Load and setup the plugin
  #   local ok, smear = pcall(require, "smear")
  #   if ok then
  #     smear.setup()
  #   end
  # '';

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;
        # additionalRuntimePaths = ["~/.config/nvim"];
        options = {
          tabstop = 2;
          shiftwidth = 2;
        };

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

        startPlugins = [
          # pkgs.vimPlugins.mini-indentscope
          (pkgs.vimUtils.buildVimPlugin {
            pname = "smear-cursor.vim";
            version = "0.5.1";
            src = pkgs.fetchFromGitHub {
              owner = "sphamba";
              repo = "smear-cursor.nvim";
              rev = "v0.5.1";
              sha256 = "sha256-oXO09JvN+mJ2ChsKxSASe6E33FXSINRduLZmTJwrntg=";
            };
            optional = false;
          })
          (pkgs.vimUtils.buildVimPlugin {
            pname = "indentmini.nvim";
            version = "main";
            src = pkgs.fetchFromGitHub {
              owner = "nvimdev";
              repo = "indentmini.nvim";
              rev = "main";
              sha256 = "sha256-iMQn9eJuwThatTg9aTKhgHQaBc1NV4h/6gGt+fhZG9k=";
            };
            optional = false;
          })
        ];
        luaConfigRC.myconfig =
          /*
          lua
          */
          ''
            require('smear_cursor').setup({
              stiffness = 0.8,
              trailing_stiffness =  0.5,
              distance_stop_animating = 0.5,
            })

            require("indentmini").setup({
                minlevel=1,
                only_current = false,
              })
            vim.cmd.highlight('IndentLine guifg=#7c6f64')
          '';
      };
    };
  };
}
