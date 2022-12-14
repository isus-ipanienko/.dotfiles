require 'nvim-treesitter.configs'.setup {
    ensure_installed = 'all',
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-cr>',
            node_incremental = '<c-cr>',
            node_decremental = '<s-cr>',
        },
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    }
}
