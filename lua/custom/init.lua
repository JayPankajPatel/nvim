-- no annoying swapfiles
vim.opt.swapfile = false
-- open with relative numbers
vim.api.nvim_command('set relativenumber')

-- centered scrolling with zz
vim.api
    .nvim_set_keymap('n', '<C-u>', '<C-u>zz', {noremap = true, silent = true})
vim.api
    .nvim_set_keymap('n', '<C-d>', '<C-d>zz', {noremap = true, silent = true})

vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "/lua/custom/configs/snippets"
