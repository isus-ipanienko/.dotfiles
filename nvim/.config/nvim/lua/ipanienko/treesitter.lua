require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "bash", "c", "cpp", "rust", "python", "lua", "c_sharp",
        "cmake", "make", "diff", "gitignore", "help",
        "json", "toml", "yaml", "dockerfile", "nix"
    },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
})
