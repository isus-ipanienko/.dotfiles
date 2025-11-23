return {
    "ThePrimeagen/harpoon",
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")
        vim.keymap.set("n", "<leader>pa", mark.add_file, { silent = true })
        vim.keymap.set("n", "<leader>po", ui.toggle_quick_menu, { silent = true })
        vim.keymap.set("n", "<C-1>", function() ui.nav_file(1) end, { silent = true })
        vim.keymap.set("n", "<C-2>", function() ui.nav_file(2) end, { silent = true })
        vim.keymap.set("n", "<C-3>", function() ui.nav_file(3) end, { silent = true })
        vim.keymap.set("n", "<C-4>", function() ui.nav_file(4) end, { silent = true })
        vim.keymap.set("n", "<C-5>", function() ui.nav_file(5) end, { silent = true })
        vim.keymap.set("n", "<C-6>", function() ui.nav_file(6) end, { silent = true })
    end
}
