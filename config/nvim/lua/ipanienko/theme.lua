vim.o.background = "dark"

require("gruvbox").setup({
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
        strings = true,
        comments = true,
        operators = false,
        folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = "hard",
    palette_overrides = {
        dark0_hard = "#000000",
    },
    overrides = {},
    dim_inactive = false,
    transparent_mode = true,
})
vim.cmd("colorscheme gruvbox")
