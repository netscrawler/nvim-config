return {
    {
        "romgrk/barbar.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "lewis6991/gitsigns.nvim",
        },
        config = function()
            require("barbar").setup({
                animation = true,
                auto_hide = true,
                tabpages = true,
            })
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        -- Команда для запуска
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- Горячие клавиши
        keys = {
            { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        },
        config = function()
            vim.g.lazygit_floating_window_scaling_factor = 0.9
        end,
    },
    -- lazydocker.nvim
    {
        "mgierada/lazydocker.nvim",
        dependencies = { "akinsho/toggleterm.nvim" },
        config = function()
            require("lazydocker").setup({
                border = "curved", -- valid options are "single" | "double" | "shadow" | "curved"
            })
        end,
        event = "BufRead",
        keys = {
            {
                "<leader>ld",
                function()
                    require("lazydocker").open()
                end,
                desc = "Open Lazydocker floating window",
            },
        },
    },
}
