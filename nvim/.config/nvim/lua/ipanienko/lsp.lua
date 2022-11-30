local on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '<leader>dj', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', '<leader>dk', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, bufopts)
    vim.keymap.set('n', '<leader>dt', '<cmd>Telescope diagnostics<cr>', bufopts)
    vim.keymap.set('n', '<leader>dh', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>ds', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>de', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>dr', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>da', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>df', function() vim.lsp.buf.format { async = true } end, bufopts)
    vim.keymap.set('n', '<leader>dc', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<leader>dd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', '<leader>di', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<leader>dt', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
    end, bufopts)
end

local lspconfig = require 'lspconfig'
local servers = { 'clangd', 'rust_analyzer', 'pyright' }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = require 'cmp_nvim_lsp'.default_capabilities(),
    }
end

lspconfig['sumneko_lua'].setup {
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

local luasnip = require 'luasnip'
luasnip.config.set_config {
    history = true,
    updateevents = 'TextChanged,TextChangedI'
}
vim.keymap.set('n', '<leader>ss', '<cmd>source ~/.config/nvim/lua/ipanienko/snippets.lua<cr>')
vim.keymap.set({ 'i', 's' }, '<c-k>', function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    end
end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<c-j>', function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end, { silent = true })

local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<c-d>'] = cmp.mapping.scroll_docs(-4),
        ['<c-f>'] = cmp.mapping.scroll_docs(4),
        ['<c-space>'] = cmp.mapping.complete(),
        ['<cr>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<s-tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
    },
}
