local keybinds = require("ipanienko.keybinds")

local lspconfig = require("lspconfig")
local servers = { "clangd", "rust_analyzer", "pyright", "csharp_ls" }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = keybinds.lsp_on_attach,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
    }
end
lspconfig["lua_ls"].setup({
    on_attach = keybinds.lsp_on_attach,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

local luasnip = require("luasnip")
luasnip.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI"
}

local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = keybinds.cmp.mapping,
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
    },
})
