-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>dm', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
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

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require('lspconfig')
local servers = { 'clangd', 'rust_analyzer', 'pyright' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

local luasnip = require 'luasnip'
luasnip.config.set_config {
    history = true,
    updateevents = 'TextChanged,TextChangedI'
}
vim.keymap.set('n', '<leader>ss', '<cmd>source ~/.config/nvim/lua/ipanienko/snippets.lua<CR>')
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
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
