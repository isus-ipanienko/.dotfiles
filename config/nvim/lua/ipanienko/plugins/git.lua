return {
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>go", vim.cmd.Git)
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                current_line_blame = true,
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    vim.keymap.set('n', ']g', gs.next_hunk, { buffer = bufnr })
                    vim.keymap.set('n', '[g', gs.prev_hunk, { buffer = bufnr })
                    vim.keymap.set({ 'n', 'v' }, '<leader>gs', gs.stage_hunk, { buffer = bufnr })
                    vim.keymap.set({ 'n', 'v' }, '<leader>gr', gs.reset_hunk, { buffer = bufnr })
                end
            })
        end
    }
}
