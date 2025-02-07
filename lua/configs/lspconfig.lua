-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "clangd", "lua_ls", "ltex" }
local nvlsp = require "nvchad.configs.lspconfig"

-- verible setup because root dir has a horrible default variable of ONLY .git
-- I changed it in lspconfig files, under
-- $HOME/.local/share/nvim/lazy/nvim-lspconfig/lua/lspconfig/configs/verilator.lua
-- lsps with default config
--
-- Seperate config for verilable because root directory has .git (horrible) default
--
--
lspconfig.verible.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  root_dir = lspconfig.util.root_pattern "verible.filelist",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
