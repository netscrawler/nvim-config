return {
    {
        "leoluz/nvim-dap-go",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        lazy = true,
        ft = "go",
        config = function()
            require("dap-go").setup()

            vim.keymap.set("n", "<leader><leader>gdm", function()
                require("dap-go").debug_test()
            end)
        end,
    },
    -- {
    --     "mfussenegger/nvim-dap-python",
    --     dependencies = {
    --         "mfussenegger/nvim-dap",
    --     },
    --     ft = "python",
    --     config = function()
    --         require("dap-python").setup()
    --     end,
    -- },
}
