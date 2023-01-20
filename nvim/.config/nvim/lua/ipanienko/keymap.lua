local setup = function()
    local builtin = require('telescope.builtin')
    local mark = require('harpoon.mark')
    local hui = require('harpoon.ui')
    local dap = require 'dap'
    local dapui = require 'dapui'
    local luasnip = require 'luasnip'

    vim.g.mapleader = " "

    vim.keymap.set('x', '<leader>i', '"_dP')

    vim.keymap.set('n', '<leader>og', '<cmd>LazyGit<cr>', { silent = true })

    vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
    vim.keymap.set('n', '<leader>pf', builtin.find_files)
    vim.keymap.set('n', '<leader>ps', builtin.live_grep)
    vim.keymap.set('n', '<leader>pg', builtin.git_files)

    vim.keymap.set('n', '<leader>tb', builtin.buffers)
    vim.keymap.set('n', '<leader>th', builtin.help_tags)

    vim.keymap.set('n', '<leader>ha', mark.add_file, { silent = true })
    vim.keymap.set('n', '<leader>ho', hui.toggle_quick_menu, { silent = true })
    vim.keymap.set('n', '<leader>h1', function() hui.nav_file(1) end, { silent = true })
    vim.keymap.set('n', '<leader>h2', function() hui.nav_file(2) end, { silent = true })
    vim.keymap.set('n', '<leader>h3', function() hui.nav_file(3) end, { silent = true })
    vim.keymap.set('n', '<leader>h4', function() hui.nav_file(4) end, { silent = true })

    vim.keymap.set('n', '<home>', function() dapui.toggle() end)
    vim.keymap.set('n', '<end>', function() dap.disconnect({ terminateDebuggee = true }) end)
    vim.keymap.set('n', '<up>', function() dap.continue() end)
    vim.keymap.set('n', '<down>', function() dap.step_over() end)
    vim.keymap.set('n', '<right>', function() dap.step_into() end)
    vim.keymap.set('n', '<left>', function() dap.step_out() end)
    vim.keymap.set('n', '<c-b>', function() dap.toggle_breakpoint() end)
    vim.keymap.set('n', '<s-b>', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
    vim.keymap.set('n', '<a-b>', function() dap.run_to_cursor() end)

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
end

local set_up = false
if not set_up then
    setup()
    set_up = true
end

local lsp_on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '<leader>dj', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', '<leader>dk', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, bufopts)
    vim.keymap.set('n', '<leader>dt', '<cmd>Telescope diagnostics<cr>', bufopts)

    vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, bufopts)

    vim.keymap.set('n', '<leader>rr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>rc', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<leader>rd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', '<leader>ri', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<leader>rt', vim.lsp.buf.type_definition, bufopts)

    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
    end, bufopts)
end

return lsp_on_attach
