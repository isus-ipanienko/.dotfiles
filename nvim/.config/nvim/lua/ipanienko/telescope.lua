require 'telescope'.setup {
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'respect_case',
        }
    }
}

require 'telescope'.load_extension('fzf')
