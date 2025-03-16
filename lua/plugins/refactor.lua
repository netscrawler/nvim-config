return {
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        lazy = false,
        config = function()
            require("telescope").load_extension("refactoring")
            require("refactoring").setup(
                {
                    prompt_func_return_type = {
                        go = true,
                        cpp = true,
                        c = true,
                        java = true,
                    },
                    -- prompt for function parameters
                    prompt_func_param_type = {
                        go = true,
                        cpp = true,
                        c = true,
                        java = true,
                    },
                },
                -- load refactoring Telescope extension

                vim.keymap.set(
                    { "n", "x" },
                    "<leader>rf",
                    function() require('telescope').extensions.refactoring.refactors() end
                )
            )
        end,
    },
}
