local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Start or continue the debugger",
    },
  }
}

M.neogen = {
  plugin = true,
  n = {
    ["<leader>gdc"] = {
      "<cmd> Neogen <CR>",
      "Generate documentation comments",
    },
  }
}

return M
