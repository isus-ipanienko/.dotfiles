local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    "clangd",
    "rust_analyzer",
    "pyright",
})

-- (Optional) Configure lua language server for neovim
require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = "E",
        warn = "W",
        hint = "H",
        info = "I"
    }
})

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

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
