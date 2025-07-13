-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'sindrets/diffview.nvim',
    'nvim-treesitter/nvim-treesitter-context',
  },
  -- {
  --   "rshkarin/mason-nvim-lint",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = {
  --     "williamboman/mason.nvim",
  --     "mfussenegger/nvim-lint",
  --   },
  --   config = function()
  --     require('mason-nvim-lint').setup({
  --       ensure_installed = { 'mypy' },
  --       ignore_install = { 'jsonlint' },
  --     })
  --
  --     local lint = require('lint')
  --     lint.linters_by_ft = {
  --       python = { 'mypy' },
  --     }
  --
  --     vim.keymap.set('n', '<leader>l', lint.try_lint, { desc = 'LSP: [L]int' })
  --   end,
  -- },
}
