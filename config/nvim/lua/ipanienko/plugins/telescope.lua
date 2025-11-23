return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.4",
        dependencies = { "nvim-lua/plenary.nvim" },
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
            vim.keymap.set("n", "<leader>pf", builtin.find_files)
            vim.keymap.set("n", "<leader>ps", builtin.live_grep)
            vim.keymap.set("n", "<leader>pg", builtin.git_files)
            vim.keymap.set("n", "<leader>pb", builtin.buffers)
            vim.keymap.set("n", "<leader>ph", builtin.help_tags)
        end
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
            require("telescope").load_extension("fzf")
        end
    }
}
