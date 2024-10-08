local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function () 
            local configs = require("nvim-treesitter.configs")

            configs.setup ({
                -- Add a language of your choice
                ensure_installed = {"cpp", "python", "lua", "java", "javascript", "kotlin", "pug"},
                sync_install = false,
                ignore_install = { "" }, -- List of parsers to ignore installing
                highlight = {
                    enable = true, -- false will disable the whole extension
                    disable = { "" }, -- list of language that will be disabled
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true, disable = { "yaml" } },
            })
        end
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'L3MON4D3/LuaSnip'},
    {
        'Exafunction/codeium.vim',
        event = 'BufEnter',
        config = function ()
            vim.keymap.set('n', '<C-g>', function () return vim.fn['codeium#Chat']() end, { expr = true, silent = true })
        end
    },
    {"folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {}},
    {
        'jinh0/eyeliner.nvim', 
        config = function()
            require'eyeliner'.setup {
                highlight_on_key = true, -- show highlights only after keypress
                dim = true              -- dim all other characters if set to true (recommended!)
            }
        end
    },
    {
        "GCBallesteros/jupytext.nvim",
        config = true,
    },
    {
        "GCBallesteros/NotebookNavigator.nvim",
        keys = {
            { "]h", function() require("notebook-navigator").move_cell "d" end },
            { "[h", function() require("notebook-navigator").move_cell "u" end },
            { "<leader>X", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
            { "<leader>x", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
        },
        dependencies = {
            "echasnovski/mini.comment",
            "hkupty/iron.nvim", -- repl provider
            "anuvyklack/hydra.nvim",
        },
        event = "VeryLazy",
        config = function()
            local nn = require "notebook-navigator"
            nn.setup({ activate_hydra_keys = "<leader>h" })
        end,
    },
    { "sedm0784/vim-resize-mode" },
})
