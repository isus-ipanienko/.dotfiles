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

require("telescope").load_extension("fzf")
require("telescope").load_extension("git_worktree")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", builtin.find_files)
vim.keymap.set("n", "<leader>ps", builtin.live_grep)
vim.keymap.set("n", "<leader>pg", builtin.git_files)
vim.keymap.set("n", "sb", builtin.buffers)
vim.keymap.set("n", "st", builtin.help_tags)

local extensions = require("telescope").extensions
vim.keymap.set("n", "<leader>gw", function() extensions.git_worktree.git_worktrees() end,
    { silent = true })
vim.keymap.set("n", "<leader>gc", function() extensions.git_worktree.create_git_worktree() end,
    { silent = true })
