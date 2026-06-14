local M = {}

M.linters_by_ft = {
  python = { "mypy" },
  verilog = { "verilator" },
  systemverilog = { "verilator" },
}

function M.setup()
  local lint = require "lint"

  lint.linters_by_ft = M.linters_by_ft

  vim.api.nvim_create_user_command("Lint", function()
    lint.try_lint()
  end, {})

  vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("UserLint", { clear = true }),
    callback = function()
      lint.try_lint()
    end,
  })
end

return M
