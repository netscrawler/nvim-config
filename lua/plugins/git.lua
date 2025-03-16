return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("gitsigns").setup()
        end,
    },
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "G" },
        keys = {
            { "<leader>gS", ":Git<CR>", desc = "Git status" },
        },
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
    {
        "akinsho/git-conflict.nvim",
        config = true,
        version = "*",
        cmd = {
            "GitConflictChooseOurs",
            "GitConflictChooseTheirs",
            "GitConflictChooseBoth",
            "GitConflictChooseNone",
            "GitConflictNextConflict",
            "GitConflictPrevConflict",
            "GitConflictListQf",
        },
    },
    {
        "rhysd/committia.vim",
        event = "User FugitiveIndex",
    },
}
