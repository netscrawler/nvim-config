return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = {
                    enabled = false,
                    auto_refresh = false,
                    keymap = {
                        jump_prev = "[[",
                        jump_next = "]]",
                        accept = "<CR>",
                        refresh = "gr",
                        open = "<M-CR>",
                    },
                    layout = {
                        position = "bottom",
                        ratio = 0.4,
                    },
                },
                suggestion = {
                    enabled = false,
                    auto_trigger = false,
                    debounce = 40,
                    keymap = {
                        accept = "<M-f>",
                        next = "<M-s>",
                        prev = "<M-d>",
                        dismiss = "<M-x>",
                    },
                },
                filetypes = {
                    -- Явно включаем поддержку Go
                    go = true,

                    -- Другие языки, которые вы хотите включить
                    rust = true,
                    lua = true,
                    python = true,

                    -- Языки, которые вы можете отключить, если нужно
                },
                -- Дополнительные настройки
                copilot_node_command = 'node', -- Путь к Node.js
                server_opts_overrides = {},
            })

            -- Добавляем команды для быстрого включения/отключения
            vim.api.nvim_create_user_command("CopilotToggle", function()
                vim.cmd("Copilot toggle")
            end, {})

            -- Горячие клавиши
            vim.keymap.set('n', '<leader>cp', ':Copilot panel<CR>', { silent = true })
            vim.keymap.set('n', '<leader>ce', ':Copilot enable<CR>', { silent = true })
            vim.keymap.set('n', '<leader>cd', ':Copilot disable<CR>', { silent = true })
        end,
    }
}
