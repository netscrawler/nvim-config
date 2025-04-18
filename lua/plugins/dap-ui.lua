return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        keys = {
            "<leader>Du",
            "<leader>DU",
        },
        lazy = true,
        config = function()
            print("dap")
            local dapui = require("dapui")

            dapui.setup()

            vim.keymap.set("n", "<leader>Du", function()
                dapui.toggle({ layout = 2 })
            end, {
                desc = "Toggle Simple Debug ui, I mainly use it to run tests",
            })

            vim.keymap.set("n", "<leader>DU", function()
                dapui.toggle()
            end, {
                desc = "Toggle Full Debug ui",
            })
        end,
    },
}
