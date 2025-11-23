return {
    {
        "mfussenegger/nvim-dap",
        lazy = false,
        config = function()
            local dap = require("dap")
            dap.adapters.lldb = {
                type = "executable",
                command = "/usr/bin/lldb-dap", -- must be absolute path
                name = "lldb"
            }

            dap.configurations.cpp = {
                {
                    name = "Launch",
                    type = "lldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.loop.cwd() .. '/', 'file')
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = {},
                },
            }

            dap.configurations.c = dap.configurations.cpp
            dap.configurations.rust = dap.configurations.cpp

            vim.keymap.set("n", "<end>", function() dap.disconnect({ terminateDebuggee = true }) end)
            vim.keymap.set("n", "<up>", function() dap.continue() end)
            vim.keymap.set("n", "<down>", function() dap.step_over() end)
            vim.keymap.set("n", "<right>", function() dap.step_into() end)
            vim.keymap.set("n", "<left>", function() dap.step_out() end)
            vim.keymap.set("n", "<C-b>", function() dap.toggle_breakpoint() end)
            vim.keymap.set("n", "<S-b>", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end)
            vim.keymap.set("n", "<A-b>", function() dap.run_to_cursor() end)
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup({
                layouts = {
                    {
                        elements = {
                            "scopes",
                            "watches",
                        },
                        size = 0.25,
                        position = "left",
                    },
                    {
                        elements = {
                            "stacks",
                            "repl",
                            -- "console",
                        },
                        size = 0.3,
                        position = "bottom",
                    },
                },
                controls = {
                    enabled = false
                },
            })

            local listeners = dap.listeners
            listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
            listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
            listeners.before.event_exited["dapui_config"] = function() dapui.close() end

            vim.keymap.set("n", "<home>", function() dapui.toggle() end)
        end
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
        config = function()
            local daptext = require("nvim-dap-virtual-text")

            daptext.setup({
                enabled = true,
            })
        end
    },
}
