return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = 'main',
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install({
                    "bash", "c", "cpp", "python", "zig", "lua",
                    "html", "css", "javascript", "cmake", "make",
                    "diff", "gitignore", "json",
            })

            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    pcall(vim.treesitter.start, args.buf)
                end,
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context"
    }
}
