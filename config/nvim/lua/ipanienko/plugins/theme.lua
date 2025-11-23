return {
    {
        "Mofiqul/vscode.nvim",
        config = function()
            vim.o.background = "dark"
            require("vscode.colors").get_colors()
            require("vscode").setup({
                transparent = true,
                italic_comments = true,
                underline_links = true,
                disable_nvimtree_bg = true,
            })
            vim.cmd.colorscheme("vscode");
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "arkav/lualine-lsp-progress"
        },
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "vscode",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = true,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    }
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = {
                        {
                            "lsp_progress",
                            display_components = { "lsp_client_name", { "title", "percentage", "message" } },
                            timer = { progress_enddelay = 500, lsp_client_name_enddelay = 1000 },
                        }
                    },
                    lualine_x = { "filename" },
                    lualine_y = { "encoding", "fileformat", "filetype" },
                    lualine_z = { "location" }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {}
            })
        end
    }
}
