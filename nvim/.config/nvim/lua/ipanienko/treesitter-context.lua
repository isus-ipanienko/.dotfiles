require("treesitter-context").setup({
    enable = true,
    max_lines = 0,
    trim_scope = "outer",
    min_window_height = 0,
    patterns = {
        default = {
            "class",
            "function",
            "method",
            "for",
            "while",
            "if",
            "switch",
            "case",
            "interface",
            "struct",
            "enum",
        },
        rust = {
            "impl_item",
        },
        markdown = {
            "section",
        },
        json = {
            "pair",
        },
        yaml = {
            "block_mapping_pair",
        },
    },
    exact_patterns = {},
    zindex = 20,
    mode = "cursor",
    separator = nil,
})
