vim.g.mapleader = " "

vim.keymap.set("n", "Q", "<nop>")

-- preserve pasted buffer
vim.keymap.set("x", "<C-i>", "\"_dP")

-- paste from yank register
vim.keymap.set("n", "<C-p>", "\"0p")

-- move highlighted text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- static cursor
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<c-d>zz")
vim.keymap.set("n", "<C-u>", "<c-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- copy to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- replace word under cursor
vim.keymap.set("n", "<leader>rw", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

vim.keymap.set("n", "<leader>u", "<CMD>UndotreeToggle<CR>")
vim.keymap.set("n", "<c-t>", "<CMD>TroubleToggle document_diagnostics<CR>", { silent = true })
vim.keymap.set("n", "<c-e>", "<CMD>TroubleToggle quickfix<CR>", { silent = true })
vim.keymap.set("n", "<leader>ss", "<CMD>source ~/.config/nvim/lua/ipanienko/snippets.lua<CR>")
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
