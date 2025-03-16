return {
    {
        "pwntester/octo.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "Octo" },
        config = function()
            require("octo").setup()
        end,
    },
    {
        "ruifm/gitlinker.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>gy", ":lua require('gitlinker').get_buf_range_url('n')<CR>", desc = "Copy GitHub URL" },
        },
        config = function()
            require("gitlinker").setup({
                mappings = nil,
            })
        end,
    },
}

