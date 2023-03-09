require("tmux").setup({
    copy_sync = {
        enable = false,
   },
    navigation = {
        cycle_navigation = false,
        enable_default_keybindings = true,
        persist_zoom = false,
    },
    resize = {
        enable_default_keybindings = true,
        resize_step_x = 1,
        resize_step_y = 1,
    }
})
