local plugins = {
  {
    event = "VeryLazy",
    'edluffy/hologram.nvim',
    config = function ()
      require("hologram").setup{
        auto_display = true
      }
    end,
  },
  {
    'akinsho/flutter-tools.nvim',
    ft = {"dart"},
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function ()
      require("flutter-tools").setup{}
    end,
  },
  {
    event = "VeryLazy",
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function ()
      require "custom.configs.neogen"
      require("core.utils").load_mappings("neogen")
    end,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*" 
  },
  {
    'lervag/vimtex',
    event = "VeryLazy",
    ft = {"tex"},
  },
  {
    lazy=false,
    "tpope/vim-surround",
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
    },
  },
  {
    "mfussenegger/nvim-dap",
    config = function(_, _)
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- C/C++ 
        "clangd",
        "clang-format",
        "codelldb",
        -- python
        "pyright",
        "mypy",
        "ruff",
        "black",
        "debugpy",
        -- bash
        "bash-language-server",
        "bash-debug-adapter",
        -- LaTeX
        "ltex-ls",
        "latexindent",
        -- dart 
        "dart-debug-adapter",
      }
    }
  }
}
return plugins
