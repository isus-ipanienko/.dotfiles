local dap = require 'dap'
local dapui = require 'dapui'
local daptext = require 'nvim-dap-virtual-text'

daptext.setup {
    enabled = true,
}

dapui.setup {
    layouts = {
        {
            elements = {
                'scopes',
                'watches',
            },
            size = 0.25,
            position = 'left',
        },
        {
            elements = {
                'stacks',
                'repl',
                -- 'console',
            },
            size = 0.3,
            position = 'bottom',
        },
        -- {
        --     elements = {
        --         'stacks',
        --     },
        --     size = 0.25,
        --     position = 'right',
        -- },
    },
    controls = {
        enabled = false
    },
}

dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
    name = 'lldb'
}

dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.loop.cwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
    },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

local listeners = dap.listeners
listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
listeners.before.event_exited['dapui_config'] = function() dapui.close() end
