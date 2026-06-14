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
