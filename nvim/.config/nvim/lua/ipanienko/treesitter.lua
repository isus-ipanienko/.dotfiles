require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
    },
  },
  refactor = {
    highlight_definitions = {
      enable = true,
      clear_on_cursor_move = true,
    },
    highlight_current_scope = {
        enable = false
    },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "gr",
      },
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gd",
        list_definitions = "gl",
        list_definitions_toc = "gt",
        goto_next_usage = "gn",
        goto_previous_usage = "gp",
      },
    },
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}
