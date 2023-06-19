
-- This file is for anything that is not standard with nvim and nvchad
vim.api.nvim_command('set relativenumber')

-- for WSL, it lets you copy and paste and yank to sys clipboard
vim.g.clipboard = {
   name = 'WslClipboard',
   copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
   },
   paste = {
      ['+'] = 'vim.fn.system("powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace(\"`r\", \"\"))")',
      ['*'] = 'vim.fn.system("powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace(\"`r\", \"\"))")',
   },
   cache_enabled = 0,
}

