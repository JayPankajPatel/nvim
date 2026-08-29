require "nvchad.mappings"

-- add yours here
local ls = require "luasnip"
vim.keymap.set({ "i", "s" }, "<Tab>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
  end
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-f>", function()
  ls.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  ls.jump(-1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

-- open with relative numbers
vim.api.nvim_command('set relativenumber')

-- centered scrolling with zz
vim.api
    .nvim_set_keymap('n', '<C-u>', '<C-u>zz', {noremap = true, silent = true})
vim.api
    .nvim_set_keymap('n', '<C-d>', '<C-d>zz', {noremap = true, silent = true})

-- close the quickfix list after jumping to a reference/quickfix entry,
-- instead of leaving it open as a squished split
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }
    vim.keymap.set("n", "<CR>", "<CR>:cclose<CR>", opts)
    vim.keymap.set("n", "q", "<cmd>cclose<CR>", opts)
  end,
})
