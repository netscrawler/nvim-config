-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "catppuccin" } },
    -- automatically check for plugin updates
    checker = { enabled = false },
    -- Add `neotest` plugin to the `lazy.nvim` setup
    {
        "nvim-neotest/neotest",
        optional = true,
        dependencies = {
            "fredrikaverpil/neotest-golang",
            "nvim-neotest/nvim-nio"
        },
        opts = {
            adapters = {
                ["neotest-golang"] = {
                    dap_go_enabled = true,
                },
            },
        },
    },
    -- Add `vim-fugitive`, `gitsigns.nvim`, `telescope-frecency.nvim`, and `diffview.nvim` plugins to the `lazy.nvim` setup
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "G" },
        keys = {
            { "<leader>gS", ":Git<CR>", desc = "Git status" },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("gitsigns").setup()
        end,
    },
    {
        "nvim-telescope/telescope-frecency.nvim",
        dependencies = { "tami5/sqlite.lua" },
        config = function()
            require("telescope").load_extension("frecency")
        end,
    },
    {
        "sindrets/diffview.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        keys = {
            { "<leader>dv", ":DiffviewOpen<CR>",        desc = "Open Diffview" },
            { "<leader>dh", ":DiffviewFileHistory<CR>", desc = "File History" },
        },
        config = true,
    },
    -- Add `outline.nvim` plugin to the `lazy.nvim` setup
    {
        "hedyhli/outline.nvim",
        config = function()
            local opts = {
                highlight_hovered_item = true,
                show_guides = true,
                position = 'right',
                width = 25,
                show_numbers = false,
                show_relative_numbers = false,
                show_symbol_details = true,
                preview_bg_highlight = 'Pmenu',
                auto_preview = true,
                keymaps = {
                    close = "<Esc>",
                    goto_location = "<Cr>",
                    focus_location = "o",
                    hover_symbol = "<C-space>",
                    toggle_preview = "K",
                    rename_symbol = "r",
                    code_actions = "a",
                    fold = "h",
                    unfold = "l",
                    fold_all = "W",
                    unfold_all = "E",
                    fold_reset = "R",
                },
                icons = {
                    func = "󰊕",
                    class = "",
                    var = "",
                    interface = "",
                    module = "󰅩",
                    struct = "",
                    field = "",
                    const = "",
                    method = "󰆧",
                    namespace = "󰅪",
                    enum = "󰕘",
                    enum_member = "󰕘",
                    property = "",
                    event = "󰃮",
                    constructor = "",
                    default = "󰈚",
                },
            }
            require("outline").setup(opts)
            vim.keymap.set('n', '<leader>no', ':Outline<CR>', { noremap = true, silent = true, desc = "Toggle Outline" })
        end,
    },
})
