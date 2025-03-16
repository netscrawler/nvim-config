return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        lsp = {
            code_actions = {
                border = "rounded",
                title = " LSP ",
                detail_separator = " • ",
            }
        },
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        explorer = { enabled = true },
        indent = { enabled = false },
        input = { enabled = true },
        picker = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = false },
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
        lazygit = {
            enabled = true,
            -- your lazygit configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            { "<leader>Gbr", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
            { "<leader>gl",  function() Snacks.picker.git_log() end,      desc = "Git Log" },
            { "<leader>gL",  function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
            { "<leader>gs",  function() Snacks.picker.git_status() end,   desc = "Git Status" },
            { "<leader>gS",  function() Snacks.picker.git_stash() end,    desc = "Git Stash" },
            { "<leader>gd",  function() Snacks.picker.git_diff() end,     desc = "Git Diff (Hunks)" },
            { "<leader>gf",  function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
            -- your key configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
}
