require 'Comment'.setup {
    -- LHS of toggle mappings in NORMAL mode
    toggler = {
        line = '<s-m>',
        block = '<c-m>',
    },
    -- LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        line = '<leader>m',
        block = '<leader><leader>m',
    },
    -- LHS of extra mappings
    extra = {
        above = '<leader>mO',
        below = '<leader>mo',
        eol = '<leader>mA',
    },
    -- Enable keybindings
    mappings = {
        basic = true,
        extra = true,
    },
    padding = true, -- Add a space b/w comment and the line
    sticky = true, -- Whether the cursor should stay at its position
    ignore = nil, -- Regex for lines to be ignored (string or function)
    pre_hook = nil,
    post_hook = nil,
}
