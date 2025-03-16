return {
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- опционально, для иконок
        },
        config = function()
            -- отключаем netrw в пользу nvim-tree
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            require('nvim-tree').setup({
                sort_by = "case_sensitive",
                view = {
                    width = 30, -- ширина окна с деревом
                    adaptive_size = true,
                },
                renderer = {
                    root_folder_label = false,
                    highlight_git = true,
                    group_empty = true,
                    indent_markers = {
                        enable = true,
                        inline_arrows = true,
                        icons = {
                            corner = "└",
                            edge = "│",
                            item = "│",
                            bottom = "─",
                            none = " ",
                        },

                    },
                    icons = {
                        show = {
                            file = true,
                            folder = true,
                            folder_arrow = true,
                            git = true,
                        },
                    },
                },
                filters = {
                    dotfiles = true, -- показывать скрытые файлы
                },
                git = {
                    enable = true,  -- включить интеграцию с git
                    ignore = false, -- не игнорировать файлы из .gitignore
                },
                actions = {
                    open_file = {
                        quit_on_open = true, -- не закрывать дерево при открытии файла
                        window_picker = {
                            enable = true,
                        },
                    },
                },
            })

            -- Настройка горячих клавиш
            vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true })    -- Ctrl+n для открытия/закрытия
            vim.keymap.set('n', '<leader>e', ':NvimTreeFocus<CR>', { silent = true }) -- <leader>e для фокуса на дереве
        end,
    },
    {
        'nvim-tree/nvim-web-devicons',
        config = function()
            require('nvim-web-devicons').setup({
                default = true,
            })
        end,
    },
}
