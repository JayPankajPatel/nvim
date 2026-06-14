**This repo is supposed to used as config by NvChad users!**

- The main nvchad repo (NvChad/NvChad) is used as a plugin by this repo.
- So you just import its modules , like `require "nvchad.options" , require "nvchad.mappings"`
- So you can delete the .git from this repo ( when you clone it locally ) or fork it :)

## Changes

This branch modernizes the config while keeping NvChad as the base layer.

- Migrated custom LSP setup from `require("lspconfig").SERVER.setup` to Neovim's `vim.lsp.config` and `vim.lsp.enable` APIs.
- Replaced archived `ltex-ls` usage with `ltex-ls-plus` via the `ltex_plus` LSP config.
- Removed `none-ls`; formatting now uses `conform.nvim`, and standalone diagnostics use `nvim-lint`.
- Added `mason-tool-installer.nvim` so external tools such as `tree-sitter-cli`, `ltex-ls-plus`, `slang-server`, formatters, and linters are installed consistently.
- Updated Treesitter setup for the rewritten `nvim-treesitter` branch and its parser installation flow.
- Added Heaton15-inspired, low-conflict plugins: `lazydev.nvim`, `fidget.nvim`, `slang-server.nvim`, and `vim-table-mode`.
- Left the larger `nvim-cmp` to `blink.cmp` and Telescope to `snacks.nvim` swaps for a separate pass because NvChad still imports and configures the current completion and picker stack.

# Credits

1) Lazyvim starter https://github.com/LazyVim/starter as nvchad's starter was inspired by Lazyvim's . It made a lot of things easier!
