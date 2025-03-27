return {
    "nvim-neotest/neotest",
    dependencies = {
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-lua/plenary.nvim",
        "fredrikaverpil/neotest-golang",
        "leoluz/nvim-dap-go",    -- required for debugging Go tests
        "mfussenegger/nvim-dap", -- general debugging support
        "rcarriga/nvim-dap-ui",  -- UI for debugging
        "nvim-neotest/nvim-nio",
    },
    lazy = true,
    config = function()
        local neotest = require("neotest")

        neotest.setup({
            adapters = {
                require("neotest-golang")({
                    -- Options for Go tests
                    args = { "-v", "-count=1" },
                    experimental = {
                        test_table = true,
                    },
                    recursive_run = true, -- Run tests recursively
                    dap_config = {        -- Debug configuration
                        type = "go",
                        request = "launch",
                        mode = "test",
                    },
                    dap_go_enabled = true, -- Enable debugging
                })
            },
            -- General neotest configuration
            icons = {
                running = "⟳",
                passed = "✓",
                failed = "✗",
                skipped = "↓",
            },
            summary = {
                enabled = true,
                expand_errors = true,
            },
            output = {
                enabled = true,
                open_on_run = true,
            },
        })
        local function run_tests_for_current_file()
            local file_path = vim.fn.expand("%:p")
            local is_test_file = string.match(file_path, "_test%.go$")

            if is_test_file then
                -- Если мы уже в тестовом файле, просто запускаем его тесты
                neotest.run.run(file_path)
            else
                -- Если мы в файле реализации, ищем соответствующий тестовый файл
                local test_file = string.gsub(file_path, "%.go$", "_test.go")

                -- Проверяем существование файла с тестами
                local f = io.open(test_file, "r")
                if f then
                    f:close()
                    neotest.run.run(test_file)
                else
                    -- Если тестовый файл не найден, пытаемся запустить тесты в том же пакете
                    local dir_path = vim.fn.fnamemodify(file_path, ":h")
                    neotest.run.run(dir_path)
                end
            end
        end
        -- Keybindings
        vim.keymap.set("n", "<leader>Tt", function() neotest.run.run() end, { desc = "Run nearest test" })
        vim.keymap.set("n", "<leader>Tf", function() neotest.run.run(vim.fn.expand("%")) end,
            { desc = "Run current file" })
        vim.keymap.set("n", "<leader>Ts", function() neotest.summary.toggle() end, { desc = "Toggle test summary" })
        vim.keymap.set("n", "<leader>Tc", function() run_tests_for_current_file() end,
            { desc = "Run tests for current file (impl or test)" })
        vim.keymap.set("n", "<leader>Ta", function() neotest.run.run("./...") end, { desc = "Run all tests in project" })
        vim.keymap.set("n", "<leader>To", function() neotest.output.open({ enter = true }) end,
            { desc = "Open test output" })
        vim.keymap.set("n", "<leader>Td", function() neotest.run.run({ strategy = "dap" }) end,
            { desc = "Debug nearest test" })
    end,
}
