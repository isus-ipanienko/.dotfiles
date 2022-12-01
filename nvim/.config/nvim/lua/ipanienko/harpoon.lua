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
