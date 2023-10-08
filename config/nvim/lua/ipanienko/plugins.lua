-- Options

vim.g.mapleader = " "
vim.opt.guicursor = ""
vim.opt.relativenumber = true
vim.opt.nu = true

vim.opt.scrolloff = 8
vim.opt.cmdheight = 1
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.wrap = false
vim.opt.errorbells = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.incsearch = true
vim.opt.hlsearch = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.updatetime = 50
vim.opt.shortmess:append("c")
vim.opt.termguicolors = true

-- Plugins

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    -- Git
    use("tpope/vim-fugitive")
    use("lewis6991/gitsigns.nvim")

    -- Comments
    use("numToStr/Comment.nvim")

    -- Navigation
    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        requires = { { "nvim-lua/plenary.nvim" } }
    })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use("ThePrimeagen/harpoon")
    use("mbbill/undotree")
    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
                icons = false
            })
        end
    })

    -- LSP
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    })
    use("nvim-treesitter/nvim-treesitter-context")
    use({
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },
            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        }
    })

    -- UI
    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true }
    })
    use("arkav/lualine-lsp-progress")
    use("rebelot/kanagawa.nvim")

    -- DAP
    -- use("mfussenegger/nvim-dap")
    -- use("rcarriga/nvim-dap-ui")
    -- use("theHamsta/nvim-dap-virtual-text")

    if packer_bootstrap then
        require("packer").sync()
    end
end)

-- Git

vim.keymap.set("n", "<leader>go", vim.cmd.Git)

require("gitsigns").setup({
    current_line_blame = true,
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        -- Actions
        map({ 'n', 'v' }, '<leader>gs', gs.stage_hunk)
        map({ 'n', 'v' }, '<leader>gr', gs.reset_hunk)
        map('n', '<leader>gu', gs.undo_stage_hunk)
        map('n', '<leader>gd', gs.diffthis)
    end
})

-- Comments

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

-- Navigation

require("telescope").setup({
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "respect_case",
        }
    }
})
require("telescope").load_extension("fzf")
local builtin = require("telescope.builtin")
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pf", builtin.find_files)
vim.keymap.set("n", "<leader>ps", builtin.live_grep)
vim.keymap.set("n", "<leader>pg", builtin.git_files)
vim.keymap.set("n", "<leader>pb", builtin.buffers)
vim.keymap.set("n", "<leader>ph", builtin.help_tags)
vim.keymap.set("n", "<leader>pa", mark.add_file, { silent = true })
vim.keymap.set("n", "<leader>po", ui.toggle_quick_menu, { silent = true })
vim.keymap.set("n", "<C-1>", function() ui.nav_file(1) end, { silent = true })
vim.keymap.set("n", "<C-2>", function() ui.nav_file(2) end, { silent = true })
vim.keymap.set("n", "<C-3>", function() ui.nav_file(3) end, { silent = true })
vim.keymap.set("n", "<C-4>", function() ui.nav_file(4) end, { silent = true })

vim.keymap.set("n", "<leader>u", "<CMD>UndotreeToggle<CR>")
vim.keymap.set("n", "<C-e>", "<CMD>TroubleToggle quickfix<CR>", { silent = true })

-- LSP

require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "bash", "c", "cpp", "rust", "python", "go", "zig", "lua", "ocaml",
        "ocaml_interface", "html", "css", "javascript", "cmake", "make",
        "diff", "gitignore", "json", "toml", "yaml", "dockerfile"
    },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
})

local lsp = require("lsp-zero")

---@diagnostic disable-next-line: unused-local
lsp.on_attach(function(client, bufnr)
    local opts = { noremap = true, buffer = bufnr }
    vim.keymap.set("n", "sd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "gj", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "gk", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>fmt", function() vim.lsp.buf.format { async = true } end, opts)
    vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "sr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "sh", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "ss", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
end)

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "bashls",
        "clangd",
        "cmake",
        "rust_analyzer",
        "pyright",
        "gopls",
        "angularls",
        "cssls",
        "html",
        "jsonls",
        "zls",
    },
    handlers = {
        lsp.default_setup,
        lua_ls = function()
            require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
        end,
    }
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
    },
    formatting = lsp.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-f>"] = cmp_action.luasnip_jump_forward(),
        ["<C-b>"] = cmp_action.luasnip_jump_backward(),
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
    })
})

-- Remaps

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("x", "<C-i>", "\"_dP")        -- preserve pasted buffer
vim.keymap.set("n", "<C-p>", "\"0p")         -- paste from yank register
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move highlighted text
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")            -- remove newline
vim.keymap.set("n", "<C-d>", "<c-d>zz")      -- static cursor
vim.keymap.set("n", "<C-u>", "<c-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>y", "\"+y") -- copy to system clipboard
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("n", "<leader>rw", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>") -- replace word
vim.keymap.set("n", "<leader>ss", "<CMD>source ~/.config/nvim/lua/ipanienko/snippets.lua<CR>")
