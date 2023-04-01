local setup = function()
    local builtin = require("telescope.builtin")
    local extensions = require("telescope").extensions
    local mark = require("harpoon.mark")
    local hui = require("harpoon.ui")
    local dap = require("dap")
    local dapui = require("dapui")
    local luasnip = require("luasnip")

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

    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    vim.keymap.set("n", "<leader>tb", builtin.buffers)
    vim.keymap.set("n", "<leader>th", builtin.help_tags)
    vim.keymap.set("n", "<c-t>", "<CMD>TroubleToggle document_diagnostics<CR>", { silent = true })
    vim.keymap.set("n", "<c-e>", "<CMD>TroubleToggle quickfix<CR>", { silent = true })

    -- git
    vim.keymap.set("n", "<leader>go", vim.cmd.Git)
    vim.keymap.set("n", "<leader>gc", function() extensions.git_worktree.git_worktrees() end,
        { silent = true })
    vim.keymap.set("n", "<leader>gn", function() extensions.git_worktree.create_git_worktree() end,
        { silent = true })

    -- navigation
    vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
    vim.keymap.set("n", "<leader>pf", builtin.find_files)
    vim.keymap.set("n", "<leader>ps", builtin.live_grep)
    vim.keymap.set("n", "<leader>pg", builtin.git_files)
    vim.keymap.set("n", "<leader>pa", mark.add_file, { silent = true })
    vim.keymap.set("n", "<leader>po", hui.toggle_quick_menu, { silent = true })
    vim.keymap.set("n", "<C-1>", function() hui.nav_file(1) end, { silent = true })
    vim.keymap.set("n", "<C-2>", function() hui.nav_file(2) end, { silent = true })
    vim.keymap.set("n", "<C-3>", function() hui.nav_file(3) end, { silent = true })
    vim.keymap.set("n", "<C-4>", function() hui.nav_file(4) end, { silent = true })

    -- debug
    vim.keymap.set("n", "<home>", function() dapui.toggle() end)
    vim.keymap.set("n", "<end>", function() dap.disconnect({ terminateDebuggee = true }) end)
    vim.keymap.set("n", "<up>", function() dap.continue() end)
    vim.keymap.set("n", "<down>", function() dap.step_over() end)
    vim.keymap.set("n", "<right>", function() dap.step_into() end)
    vim.keymap.set("n", "<left>", function() dap.step_out() end)
    vim.keymap.set("n", "<C-b>", function() dap.toggle_breakpoint() end)
    vim.keymap.set("n", "<S-b>", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end)
    vim.keymap.set("n", "<A-b>", function() dap.run_to_cursor() end)

    -- snippets
    vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        end
    end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if luasnip.jumpable(-1) then
            luasnip.jump(-1)
        end
    end, { silent = true })
    vim.keymap.set("n", "<leader>ss", "<CMD>source ~/.config/nvim/lua/ipanienko/snippets.lua<CR>")

    -- comments
    require("Comment").setup({
        toggler = {
            line = "<S-m>",
            block = "<C-m>",
        },
        opleader = {
            line = "m",
        },
        extra = {
            above = "mO",
            below = "mo",
            eol = "mA",
        },
        mappings = {
            basic = true,
            extra = true,
        },
        padding = true,
        sticky = true,
        ignore = nil,
        pre_hook = nil,
        post_hook = nil,
    })
end

local set_up = false
if not set_up then
    setup()
    set_up = true
end

local M = {}

local cmp = require("cmp")
M.cmp = {
    mapping = cmp.mapping.preset.insert({
        ["<C-h>"] = cmp.mapping.scroll_docs(-4),
        ["<C-l>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-y>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "i", "s" }),
    })
}

M.lsp_on_attach = function(client, bufnr)
    local opts = { noremap = true, buffer = bufnr }
    vim.keymap.set("n", "sd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "gj", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "gk", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>fmt", function() vim.lsp.buf.format { async = true } end, opts)
    vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "sr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "sh", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "ss", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
end

M.treesitter_keymaps = {
    init_selection = "<C-CR>",
    node_incremental = "<C-CR>",
    node_decremental = "<S-CR>",
}

return M
