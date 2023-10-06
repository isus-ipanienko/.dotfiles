local lsp = require("lsp-zero")

---@diagnostic disable-next-line: unused-local
lsp.on_attach(function(client, bufnr)
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
end)

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = {
        "bashls",
        "clangd",
        "cmake",
        "rust_analyzer",
        "pyright",
        "gopls",
        "angularls",
        "cssls",
        "html",
        "jsonls",
        "zls",
    },
    handlers = {
        lsp.default_setup,
        lua_ls = function()
            require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
        end,
    }
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
    },
    formatting = lsp.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<C-Space>"] = cmp.mapping.complete(),

        ["<C-f>"] = cmp_action.luasnip_jump_forward(),
        ["<C-b>"] = cmp_action.luasnip_jump_backward(),

        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),

        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
    })
})
