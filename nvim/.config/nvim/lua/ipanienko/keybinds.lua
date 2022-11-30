vim.g.mapleader = " "

vim.keymap.set('n', '<leader>E', ':.,.+')
vim.keymap.set('x', '<leader>p', '"_dP')

vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<cr>', { silent = true })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

local mark = require('harpoon.mark')
vim.keymap.set('n', '<leader>jj', mark.add_file, { silent = true })
vim.keymap.set('n', '<leader>ji1', function() mark.set_current_at(1) end, { silent = true })
vim.keymap.set('n', '<leader>ji2', function() mark.set_current_at(2) end, { silent = true })
vim.keymap.set('n', '<leader>ji3', function() mark.set_current_at(3) end, { silent = true })
vim.keymap.set('n', '<leader>ji4', function() mark.set_current_at(4) end, { silent = true })

local hui = require('harpoon.ui')
vim.keymap.set('n', '<leader>jm', hui.toggle_quick_menu, { silent = true })
vim.keymap.set('n', '<leader>j1', function() hui.nav_file(1) end, { silent = true })
vim.keymap.set('n', '<leader>j2', function() hui.nav_file(2) end, { silent = true })
vim.keymap.set('n', '<leader>j3', function() hui.nav_file(3) end, { silent = true })
vim.keymap.set('n', '<leader>j4', function() hui.nav_file(4) end, { silent = true })
