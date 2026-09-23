vim.pack.add {
  {
    src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
    version = vim.version.range('3')
  },
  -- dependencies
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  -- optional, but recommended
  "https://github.com/nvim-tree/nvim-web-devicons",
}
vim.keymap.set("n", "<leader>o", "<Cmd>Neotree toggle<CR>")


vim.pack.add({ {
    src = "https://github.com/kylechui/nvim-surround",
    version = vim.version.range("4.x"),
} })

vim.pack.add { 'https://codeberg.org/andyg/leap.nvim' }
-- Jump
vim.keymap.set({ 'n', 'x', 'o' }, 's',  '<Plug>(leap)')


vim.pack.add { 'https://github.com/sindrets/diffview.nvim' }

require('diffview').setup {
  default_args = {
    DiffviewOpen = { '--imply-local' },
  },
}

vim.keymap.set({ 'n', 'x' }, '<leader>gd', function()
  if next(require('diffview.lib').views) == nil then
    vim.cmd 'DiffviewOpen'
  else
    vim.cmd 'DiffviewClose'
  end
end, { desc = 'Toggle DiffView' })

vim.keymap.set({ 'n', 'x' }, '<leader>gm', function()
  if next(require('diffview.lib').views) == nil then
    vim.cmd 'DiffviewOpen main...HEAD'
  end
end, { desc = 'Open DiffView for current vs last common commit with main' })

vim.keymap.set({ 'n', 'x' }, '<leader>gb', function()
  if next(require('diffview.lib').views) == nil then
    local builtin = require 'telescope.builtin'
    local actions = require 'telescope.actions'
    local action_state = require 'telescope.actions.state'

    builtin.git_branches {
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          vim.cmd('DiffviewOpen ' .. selection.value .. '...HEAD')
        end)
        return true
      end,
    }
  end
end, { desc = 'Open DiffView for current vs last common commit with main' })

vim.pack.add { "https://github.com/ruifm/gitlinker.nvim" }
require("gitlinker").setup()

vim.pack.add { 'https://github.com/arakkkkk/kanban.nvim' }

require('kanban').setup {
  markdown = {
    description_folder = './tasks/',
    list_head = '## ',
  },
}

vim.keymap.set('n', '<leader>k', function()
  if vim.fn.filereadable './tasks.md' == 0 then
    vim.cmd 'KanbanCreate ./tasks.md'
  end
  vim.cmd 'KanbanOpen ./tasks.md'
end, { desc = 'Open Kanban tasks' })

vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter-context' }

vim.pack.add {
  'https://github.com/nvimtools/hydra.nvim',
  'https://github.com/jbyuki/venn.nvim',
}

local Hydra = require 'hydra'

local venn_hint_utf = [[
 Arrow^^^^^^  Select region with <C-v>^^^^^^
 ^ ^ _K_ ^ ^  _f_: Surround with box ^ ^ ^ ^
 _H_ ^ ^ _L_  _<C-h>_: ◄, _<C-j>_: ▼
 ^ ^ _J_ ^ ^  _<C-k>_: ▲, _<C-l>_: ► _<C-c>_
]]

Hydra {
  name = 'Draw Utf-8 Venn Diagram',
  hint = venn_hint_utf,
  config = {
    color = 'pink',
    invoke_on_body = true,
    on_enter = function()
      vim.wo.virtualedit = 'all'
    end,
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
}

vim.pack.add({
  {
    src = "https://github.com/nickjvandyke/opencode.nvim",
    version = vim.version.range("*"), -- Latest stable release
  },
})
---@type opencode.Opts
vim.g.opencode_opts = {
  -- Your configuration, if any; goto definition on the type for details
}
-- Recommended/example keymaps
vim.keymap.set({ "n", "x" }, "<C-a>",   function() require("opencode").ask("@this: ") end,                    { desc = "Ask OpenCode…" })
vim.keymap.set({ "n", "x" }, "<C-x>",   function() require("opencode").select() end,                          { desc = "Select OpenCode…" })
vim.keymap.set({ "n", "x" }, "go",      function() return require("opencode").operator("@this") end,         { desc = "Send range to OpenCode", expr = true })
vim.keymap.set({ "n" },      "goo",     function() return require("opencode").operator("@this") .. "_" end,  { desc = "Send line to OpenCode", expr = true })

vim.pack.add({
	"https://github.com/folke/snacks.nvim",
	-- "https://github.com/nvim-tree/nvim-web-devicons",
})
local Snacks = require("snacks")
Snacks.setup({
  bigfile = { enabled = true },
  -- dashboard = { enabled = true },
  explorer = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  picker = { enabled = true },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
})
