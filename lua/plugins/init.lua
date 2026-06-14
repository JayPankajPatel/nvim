return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "lazy.nvim", words = { "LazyVim" } },
      },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "mason-org/mason.nvim",
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "prettier",
        "black",
        "isort",
        "latexindent",
        "texlab",
        "mypy",
        "ruff",
        "clangd",
        "clang-format",
        "verible",
        "ltex-ls-plus",
        "slang-server",
        "tree-sitter-cli",
      },
      run_on_start = true,
      start_delay = 3000,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = function()
      if vim.fn.executable "tree-sitter" == 1 then
        vim.cmd "TSUpdate"
      end
    end,
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "bash",
        "c",
        "cpp",
        "latex",
        "markdown",
        "markdown_inline",
        "python",
        "rst",
        "systemverilog",
        "vhdl",
        "yaml",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter").setup()
      if vim.fn.executable "tree-sitter" == 1 then
        require("nvim-treesitter").install(opts.ensure_installed)
      end
    end,
  },
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
      -- vim.opt.conceallevel = 1
      -- vim.g.tex_conceal = "abdmg"
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    event = "VeryLazy",
    dependencies = { "rafamadriz/friendly-snippets" },
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    config = function()
      require("luasnip").config.set_config {
        enable_autosnippets = true,
        store_selection_keys = "<Tab>",
      }
      require("luasnip.loaders.from_vscode").lazy_load()
      -- Somewhere in your Neovim startup, e.g. init.lua
      require("luasnip").config.set_config { -- Setting LuaSnip config
        -- Use <Tab> (or some other key if you prefer) to trigger visual selection
        store_selection_keys = "<Tab>",
        enable_autosnippets = true,
      }
      require("luasnip.loaders.from_lua").lazy_load { paths = "~/.config/nvim/lua/configs/LuaSnip/" }
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require("configs.lint").setup()
    end,
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {},
  },
  {
    "hudson-trading/slang-server.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
    keys = {
      { "<leader>vv", "<cmd>SlangServer setTopLevel<CR><cmd>SlangServer hierarchy<CR>", desc = "Slang hierarchy" },
    },
  },
  {
    "dhruvasagar/vim-table-mode",
    event = "VeryLazy",
  },
}
