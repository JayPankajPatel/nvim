local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require "null-ls"

local opts = {
  sources = {
    -- C/C++
    null_ls.builtins.formatting.clang_format,
    -- python
    null_ls.builtins.formatting.black,
    null_ls.builtins.diagnostics.mypy,
    -- null_ls.builtins.diagnostics.ruff,
    -- LaTeX
    --null_ls.builtins.formatting.latexindent,

    -- Verilog, SystemVerilog
    null_ls.builtins.formatting.verible_verilog_format,
    null_ls.builtins.diagnostics.verilator,
  },
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds {
        group = augroup,
        buffer = bufnr,
      }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,
}

return opts
