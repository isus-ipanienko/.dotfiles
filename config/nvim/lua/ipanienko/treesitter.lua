require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "bash", "c", "cpp", "rust", "python", "go", "lua",
        "cmake", "make", "diff", "gitignore",
        "json", "toml", "yaml", "dockerfile"
    },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
})
