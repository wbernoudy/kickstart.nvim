-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'sindrets/diffview.nvim',
    config = function ()
      require("diffview").setup({
        default_args = {
          DiffviewOpen = { "--imply-local" },
        },
      })
    end,
    keys = {
      {
        "<leader>gd",
        function()
          if next(require("diffview.lib").views) == nil then
            vim.cmd("DiffviewOpen")
          else
            vim.cmd("DiffviewClose")
          end
        end,
        desc = "Toggle DiffView",
        mode = { "n", "x" }
      },
      {
        "<leader>gm",
        function()
          if next(require("diffview.lib").views) == nil then
            vim.cmd("DiffviewOpen main...HEAD")
          end
        end,
        desc = "Open DiffView for current vs last common commit with main",
        mode = { "n", "x" }
      },
      {
        "<leader>gb",
        function()
          if next(require("diffview.lib").views) == nil then
            -- vim.cmd("DiffviewOpen main...HEAD")

            local builtin = require 'telescope.builtin'
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')

            builtin.git_branches({
              attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function ()
                  actions.close(prompt_bufnr)
                  local selection = action_state.get_selected_entry()
                  vim.cmd("DiffviewOpen " .. selection.value .. "...HEAD")
                end)
                return true
              end
            })
          end
        end,
        desc = "Open DiffView for current vs last common commit with main",
        mode = { "n", "x" }
      },
    },
  },
  {
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
  {
    "arakkkkk/kanban.nvim",
    -- Optional
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },

    config = function()
      require("kanban").setup({
        markdown = {
          description_folder = "./tasks/", -- Path to save the file corresponding to the task.
          list_head = "## ",
        },
      })

      vim.keymap.set('n', '<leader>k', function()
        if vim.fn.filereadable("./tasks.md") == 0 then
          vim.cmd("KanbanCreate ./tasks.md")
        end
        vim.cmd("KanbanOpen ./tasks.md")
      end, { desc = 'Open Kanban tasks' })

    end,
  },

  {
    "nvimtools/hydra.nvim",
    dependencies = {
      "jbyuki/venn.nvim",
    },
    config = function()
      -- create hydras in here
      local Hydra = require("hydra")

      local venn_hint_utf = [[
 Arrow^^^^^^  Select region with <C-v>^^^^^^
 ^ ^ _K_ ^ ^  _f_: Surround with box ^ ^ ^ ^
 _H_ ^ ^ _L_  _<C-h>_: ◄, _<C-j>_: ▼
 ^ ^ _J_ ^ ^  _<C-k>_: ▲, _<C-l>_: ► _<C-c>_
]]

      -- :setlocal ve=all
      -- :setlocal ve=none
      Hydra({
        name = 'Draw Utf-8 Venn Diagram',
        hint = venn_hint_utf,
        config = {
          color = 'pink',
          invoke_on_body = true,
          on_enter = function() vim.wo.virtualedit = 'all' end,
        },
        mode = 'n',
        body = '<leader>ve',
        heads = {
          { '<C-h>', 'xi<C-v>u25c4<Esc>' }, -- mode = 'v' somehow breaks
          { '<C-j>', 'xi<C-v>u25bc<Esc>' },
          { '<C-k>', 'xi<C-v>u25b2<Esc>' },
          { '<C-l>', 'xi<C-v>u25ba<Esc>' },
          { 'H', '<C-v>h:VBox<CR>' },
          { 'J', '<C-v>j:VBox<CR>' },
          { 'K', '<C-v>k:VBox<CR>' },
          { 'L', '<C-v>l:VBox<CR>' },
          { 'f', ':VBox<CR>', { mode = 'v' } },
          { '<C-c>', nil, { exit = true } },
        },
      })

    end
  },

  {
    "juacker/git-link.nvim",
    keys = {
      {
        "<leader>gu",
        function() require("git-link.main").copy_line_url() end,
        desc = "Copy code link to clipboard",
        mode = { "n", "x" }
      },
      {
        "<leader>go",
        function() require("git-link.main").open_line_url() end,
        desc = "Open code link in browser",
        mode = { "n", "x" }
      },
    },
  }
}
