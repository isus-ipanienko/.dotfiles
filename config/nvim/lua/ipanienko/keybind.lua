-- Replace word
vim.keymap.set("n", "<leader>rw", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Paste, preserve buffer
vim.keymap.set("x", "<C-p>", "\"_dP")

-- Paste from yank register
vim.keymap.set("n", "<C-p>", "\"0p")

-- Move highlighted lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Remove newline
vim.keymap.set("n", "J", "mzJ`z")

-- Static cursor
vim.keymap.set("n", "<C-d>", "<c-d>zz")
vim.keymap.set("n", "<C-u>", "<c-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Disable Q
vim.keymap.set("n", "Q", "<nop>")

-- Open netrw
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

local ipanienko_group = vim.api.nvim_create_augroup('ipanienko', {})

vim.api.nvim_create_autocmd('LspAttach', {
    group = ipanienko_group,
    callback = function(e)
        local opts = { buffer = e.buf }
        -- Show section
        vim.keymap.set("n", "sf", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "sr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "sh", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "ss", vim.lsp.buf.signature_help, opts)

        -- Go section
        vim.keymap.set("n", "gj", function() vim.diagnostic.jump { count = 1, float = true } end, opts)
        vim.keymap.set("n", "gk", function() vim.diagnostic.jump { count = -1, float = true } end, opts)

        -- Other commands
        vim.keymap.set("n", "<leader>fmt", function() vim.lsp.buf.format { async = true } end, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    end
})
