-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

local function configure(server, config)
  config = vim.tbl_deep_extend("force", {
    capabilities = nvlsp.capabilities,
    on_init = nvlsp.on_init,
  }, config or {})

  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end

local function pyright_root(bufnr, on_dir)
  local path = vim.api.nvim_buf_get_name(bufnr)
  local root = vim.fs.root(path, {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    ".git",
  })

  if root then
    on_dir(root)
  end
end

configure "clangd"

-- Replace your current configure("pyright", ...) block with this setup:
configure("pyright", {
  root_dir = pyright_root,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
      },
    },
  },
  on_init = function(client)
    -- Fire NvChad's internal on_init default rules first to preserve hooks
    if nvlsp.on_init then
      nvlsp.on_init(client)
    end

    -- Run git rev-parse asynchronously to anchor paths to project root
    vim.system({ "git", "rev-parse", "--show-toplevel" }, { text = true }, function(obj)
      if obj.code == 0 and obj.stdout then
        local git_root = vim.trim(obj.stdout)
        local pixi_python = git_root .. "/.pixi/envs/default/bin/python"

        -- Safely inject into Pyright settings on the main execution thread
        vim.schedule(function()
          if vim.fn.executable(pixi_python) == 1 then
            client.config.settings.python.pythonPath = pixi_python
            client.notify("workspace/didChangeConfiguration", {
              settings = client.config.settings,
            })
          end
        end)
      end
    end)
    return true
  end,
})

-- linting/formatting/import-sorting; pyright stays on for type checking + hover
configure("ruff", {
  cmd = { "ruff", "server" },
  root_dir = pyright_root,
  init_options = {
    settings = {
      -- avoid duplicate hover popups with pyright
      hover = { enable = false },
    },
  },
})

configure "ltex_plus"

configure "texlab"

configure("verible", {
  root_markers = { "verible.filelist" },
})

configure("slang_server", {
  cmd = { "slang-server" },
  filetypes = { "systemverilog", "verilog" },
  root_markers = { ".slang", ".git" },
})

configure("capl_ls", {
  cmd = { "/home/jay/Repos/capl-ls/target/debug/capl-ls" },
  filetypes = { "capl" },
  root_markers = { ".git" },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspModern", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
      vim.keymap.set("n", "<leader>cth", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = args.buf }, { bufnr = args.buf })
      end, { buffer = args.buf, desc = "LSP Toggle inlay hints" })
    end
  end,
})
