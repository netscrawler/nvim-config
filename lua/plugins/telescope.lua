return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        require('telescope').setup({
            defaults = {
                -- Включаем поиск скрытых файлов
                hidden = true,
                -- Игнорируем .git директорию, но показываем другие скрытые файлы
                file_ignore_patterns = {
                    "^.git/",
                    "node_modules"
                },
            },
            pickers = {
                find_files = {
                    hidden = true, -- Включаем поиск скрытых файлов для find_files
                },
                live_grep = {
                    additional_args = function()
                        return { "--hidden" } -- Включаем поиск скрытых файлов для live_grep
                    end
                },
            },
        })

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<C-p>', function()
            builtin.find_files({
                hidden = true,    -- Дополнительно убеждаемся, что hidden включен
                no_ignore = true, -- false означает, что файлы из .gitignore все еще игнорируются
                -- Если вы хотите видеть также файлы из .gitignore, установите no_ignore = true
            })
        end, {})

        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({
                search = word,
                additional_args = function()
                    return { "--hidden" }
                end
            })
        end)

        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({
                search = word,
                additional_args = function()
                    return { "--hidden" }
                end
            })
        end)

        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({
                search = vim.fn.input("Grep > "),
                additional_args = function()
                    return { "--hidden" }
                end
            })
        end)

        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
        vim.api.nvim_set_keymap('n', '<leader>bb', ':Telescope buffers<CR>', { noremap = true, silent = true })
    end
}
