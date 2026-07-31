return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "v0.2.2",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        config = function()
            require("telescope").setup({
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "respect_case",
                    }
                }
            })

            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>pf", builtin.live_grep)
            vim.keymap.set("n", "<leader>ps", builtin.git_files)
            vim.keymap.set("n", "<leader>pd", builtin.diagnostics)
            vim.keymap.set("n", "<leader>ph", builtin.help_tags)

            vim.keymap.set("n", "gi", builtin.lsp_implementations)
            vim.keymap.set("n", "gd", builtin.lsp_definitions)
            vim.keymap.set("n", "gp", builtin.lsp_type_definitions)
            vim.keymap.set("n", "gs", builtin.lsp_references)
        end
    }
}
