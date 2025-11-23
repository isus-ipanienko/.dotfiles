return {
    "numToStr/Comment.nvim",
    config = function()
        require("Comment").setup({
            toggler = {
                line = "<S-m>",
                block = "<C-m>",
            },
            opleader = {
                line = "m",
            },
            extra = {
                above = "mO",
                below = "mo",
                eol = "mA",
            },
            mappings = {
                basic = true,
                extra = true,
            },
            padding = true,
            sticky = true,
            ignore = nil,
            pre_hook = nil,
            post_hook = nil,
        })
    end
}
