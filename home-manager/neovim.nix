{
  pkgs,
  # lib,
  ...
}:
{
  programs.neovim = {
    enable = true;
    viAlias = false;
    vimAlias = true;

    # LSP servers, formatters and tools (nvf: languages.* / lsp / telescope)
    extraPackages = with pkgs; [
      # language servers
      nil
      pyright
      bash-language-server
      lua-language-server
      clang-tools # clangd + clang-format
      vscode-langservers-extracted # html
      gopls
      marksman
      # formatters
      alejandra
      black
      stylua
      shfmt
      prettier
      # telescope live_grep / find_files
      ripgrep
      fd
      # spell / misc
      git
    ];

    plugins = with pkgs.vimPlugins; [
      # theme / visuals
      gruvbox-nvim
      nvim-web-devicons
      lualine-nvim
      bufferline-nvim
      nvim-scrollbar
      nvim-cursorline
      highlight-undo-nvim
      cinnamon-nvim
      fidget-nvim
      vim-illuminate
      nvim-colorizer-lua
      noice-nvim
      nui-nvim

      # syntax
      nvim-treesitter.withAllGrammars

      # lsp / completion / formatting
      nvim-lspconfig
      blink-cmp
      conform-nvim

      # debugging
      nvim-dap
      nvim-dap-ui
      nvim-nio

      # navigation / utility
      telescope-nvim
      plenary-nvim
      # cheatsheet-nvim
      which-key-nvim
      toggleterm-nvim
      gitsigns-nvim
      comment-nvim
      nvim-surround
      multicursors-nvim
      hydra-nvim
      hop-nvim
      leap-nvim

      smear-cursor-nvim

      # your custom plugins (same as startPlugins in the nvf config)
      # (pkgs.vimUtils.buildVimPlugin {
      #   pname = "smear-cursor.vim";
      #   version = "0.5.1";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "sphamba";
      #     repo = "smear-cursor.nvim";
      #     rev = "v0.5.1";
      #     sha256 = "sha256-oXO09JvN+mJ2ChsKxSASe6E33FXSINRduLZmTJwrntg=";
      #   };
      # })
      (pkgs.vimUtils.buildVimPlugin {
        pname = "indentmini.nvim";
        version = "main";
        src = pkgs.fetchFromGitHub {
          owner = "nvimdev";
          repo = "indentmini.nvim";
          rev = "main";
          sha256 = "sha256-XcoBNrvFMmEMcgrknDg/HnxRNssom6vLeOKiu1qJKBo=";
        };
      })
    ];

    # NOTE: inside this Nix ''...'' string never write two single quotes in a row
    # (use "" for empty strings) and escape a literal ${ as ''${.
    initLua = ''
      ---------------------------------------------------------------------------
      -- Options (nvf: options / spellcheck / ui.borders)
      ---------------------------------------------------------------------------
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

      local o = vim.opt
      o.tabstop = 2
      o.shiftwidth = 2
      o.expandtab = true
      o.number = true
      o.relativenumber = true
      o.termguicolors = true
      o.mouse = "a"
      o.splitright = true
      o.splitbelow = true
      o.spell = true
      o.spelllang = { "en" }
      o.winborder = "rounded" -- nvf: ui.borders (needs nvim 0.11+)

      ---------------------------------------------------------------------------
      -- Theme (nvf: theme gruvbox, dark, not transparent)
      ---------------------------------------------------------------------------
      vim.o.background = "dark"
      require("gruvbox").setup({ transparent_mode = false })
      vim.cmd.colorscheme("gruvbox")

      ---------------------------------------------------------------------------
      -- Tree-sitter (nvf: languages.enableTreesitter)
      -- Grammars come from withAllGrammars; highlighting is started per buffer.
      ---------------------------------------------------------------------------
      vim.api.nvim_create_autocmd("FileType", {
        callback = function() pcall(vim.treesitter.start) end,
      })

      ---------------------------------------------------------------------------
      -- Completion (blink.cmp; Tab accepts / jumps snippets)
      -- Remove this block and the capabilities line below if you don't want it.
      ---------------------------------------------------------------------------
      require("blink.cmp").setup({
        keymap = { preset = "super-tab" },
        sources = { default = { "lsp", "path", "snippets", "buffer" } },
      })

      ---------------------------------------------------------------------------
      -- LSP (nvf: lsp.enable + languages.*)
      ---------------------------------------------------------------------------
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      vim.lsp.config("clangd", {
        -- lets clangd ask the Nix compiler wrapper for its include paths
        cmd = { "clangd", "--query-driver=/nix/store/*/bin/*" },
      })

      vim.lsp.enable({
        "nil_ls",    -- nix
        "pyright",   -- python
        "bashls",    -- bash
        "lua_ls",    -- lua
        "clangd",    -- c / c++
        "html",      -- html
        "gopls",     -- go
        "marksman",  -- markdown
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local function m(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
          end
          m("K", vim.lsp.buf.hover, "Hover")
          m("<leader>lgd", vim.lsp.buf.definition, "Go to definition")
          m("<leader>lgD", vim.lsp.buf.declaration, "Go to declaration")
          m("<leader>lgr", vim.lsp.buf.references, "References")
          m("<leader>lgi", vim.lsp.buf.implementation, "Implementation")
          m("<leader>la", vim.lsp.buf.code_action, "Code action")
          m("<leader>lr", vim.lsp.buf.rename, "Rename")
          m("<leader>lf", function() require("conform").format({ lsp_format = "fallback" }) end, "Format")
          m("<leader>le", vim.diagnostic.open_float, "Line diagnostics")
          m("<leader>lgn", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")
          m("<leader>lgp", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev diagnostic")
        end,
      })

      ---------------------------------------------------------------------------
      -- Formatting on save (nvf: lsp.formatOnSave + languages.enableFormat)
      ---------------------------------------------------------------------------
      require("conform").setup({
        formatters_by_ft = {
          nix = { "alejandra" },
          python = { "black" },
          lua = { "stylua" },
          go = { "gofmt" },
          c = { "clang_format" },
          cpp = { "clang_format" },
          sh = { "shfmt" },
          bash = { "shfmt" },
          html = { "prettier" },
          markdown = { "prettier" },
        },
        formatters = {
          clang_format = {
            prepend_args = {
              "--style={BasedOnStyle: LLVM, IndentWidth: 2, TabWidth: 2, UseTab: Never}",
            },
          },
        },
        format_on_save = { timeout_ms = 1500, lsp_format = "fallback" },
      })

      ---------------------------------------------------------------------------
      -- UI plugins (nvf: ui.*, visuals.*, statusline, tabline, binds)
      ---------------------------------------------------------------------------
      require("lualine").setup({ options = { theme = "gruvbox" } })
      require("bufferline").setup({})
      require("scrollbar").setup()
      require("nvim-cursorline").setup()
      require("highlight-undo").setup()
      require("cinnamon").setup()
      require("fidget").setup({})
      require("colorizer").setup()
      require("illuminate").configure({})
      require("noice").setup({})
      require("which-key").setup({})
      -- require("cheatsheet").setup()

      -- Which-Key groups
      local wk = require("which-key")

      wk.add({
        { "<leader>f", group = "Find" },
        { "<leader>l", group = "LSP" },
        { "<leader>d", group = "Debug" },
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "Hop" },
        { "<leader>m", group = "Multicursor" },
      })

      ---------------------------------------------------------------------------
      -- Git (nvf: git.gitsigns, codeActions disabled)
      ---------------------------------------------------------------------------
      require("gitsigns").setup({})

      ---------------------------------------------------------------------------
      -- Terminal (nvf: toggleterm)
      ---------------------------------------------------------------------------
      require("toggleterm").setup({ open_mapping = [[<c-t>]] })

      ---------------------------------------------------------------------------
      -- Utility (nvf: surround, multicursors, hop, leap, comments)
      ---------------------------------------------------------------------------
      require("Comment").setup()
      require("nvim-surround").setup({})
      require("multicursors").setup({})
      require("hop").setup({})

      vim.keymap.set({ "n", "v" }, "<leader>m", "<cmd>MCstart<cr>", { desc = "Multicursor" })
      vim.keymap.set("n", "<leader>h", "<cmd>HopWord<cr>", { desc = "Hop to word" })
      vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)", { desc = "Leap" })
      vim.keymap.set("n", "S", "<Plug>(leap-from-window)", { desc = "Leap from window" })

      ---------------------------------------------------------------------------
      -- Telescope (nvf: telescope)
      ---------------------------------------------------------------------------
      local tb = require("telescope.builtin")
      -- vim.keymap.set("n", "<leader>ff", tb.find_files, { desc = "Find files" })
      -- vim.keymap.set("n", "<leader>fg", tb.live_grep, { desc = "Live grep" })
      -- vim.keymap.set("n", "<leader>fb", tb.buffers, { desc = "Buffers" })
      -- vim.keymap.set("n", "<leader>fh", tb.help_tags, { desc = "Help tags" })
      -- vim.keymap.set("n", "<leader>fld", tb.diagnostics, { desc = "Diagnostics" })
      local tb = require("telescope.builtin")

      vim.keymap.set("n", "<leader>ff", tb.find_files, {
        desc = "Find files",
      })

      vim.keymap.set("n", "<leader>fg", tb.live_grep, {
        desc = "Live grep",
      })

      vim.keymap.set("n", "<leader>fb", tb.buffers, {
        desc = "Buffers",
      })

      vim.keymap.set("n", "<leader>fh", tb.help_tags, {
        desc = "Help tags",
      })

      vim.keymap.set("n", "<leader>fd", tb.diagnostics, {
        desc = "Diagnostics",
      })


      ---------------------------------------------------------------------------
      -- Debugger (nvf: debugger.nvim-dap + ui). No adapters were configured in
      -- the nvf setup either; add e.g. codelldb / delve / debugpy as needed.
      ---------------------------------------------------------------------------
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
      vim.keymap.set("n", "<leader>dso", dap.step_over, { desc = "Step over" })
      vim.keymap.set("n", "<leader>dsi", dap.step_into, { desc = "Step into" })
      vim.keymap.set("n", "<leader>dsu", dap.step_out, { desc = "Step out" })
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })

      ---------------------------------------------------------------------------
      -- Your custom plugins (nvf: luaConfigRC.myconfig)
      ---------------------------------------------------------------------------
      require("smear_cursor").setup({
       stiffness = 0.8,
       trailing_stiffness = 0.5,
       distance_stop_animating = 0.5,
      })

      require("indentmini").setup({
        minlevel = 1,
        only_current = false,
      })
      vim.cmd.highlight("IndentLine guifg=#7c6f64")
    '';
  };
}
