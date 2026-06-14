local formatters_by_ft = {
  lua = { "stylua" },
  python = { "isort", "black" },
  c = { "clang_format" },
  cpp = { "clang_format" },
  verilog = { "verible" },
  systemverilog = { "verible" },
  tex = { "latexindent" },
  plaintex = { "latexindent" },
  -- css = { "prettier" },
  -- html = { "prettier" },
}

local format_on_save = {
  lua = true,
  python = true,
  c = true,
  cpp = true,
  verilog = true,
  systemverilog = true,
}

local options = {
  formatters_by_ft = formatters_by_ft,

  format_on_save = function(bufnr)
    if not format_on_save[vim.bo[bufnr].filetype] then
      return
    end

    return {
      timeout_ms = 1000,
      lsp_format = "fallback",
    }
  end,
}

return options
