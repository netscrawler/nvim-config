return {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
        "fredrikaverpil/neotest-golang",
        "nvim-neotest/nvim-nio"
    },
    opts = {
        adapters = {
            ["neotest-golang"] = {
                -- Here we can set options for neotest-golang, e.g.
                -- go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
                dap_go_enabled = true, -- requires leoluz/nvim-dap-go
            },
        },
    },
}

-- Add key mappings for running tests and viewing test results using `neotest`
vim.keymap.set("n", "<leader>tt", function() require("neotest").run.run() end, { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "Run tests in file" })
vim.keymap.set("n", "<leader>ts", function() require("neotest").summary.toggle() end, { desc = "Toggle test summary" })
vim.keymap.set("n", "<leader>to", function() require("neotest").output.open({ enter = true }) end, { desc = "Show test output" })
