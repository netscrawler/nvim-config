-- return {
--     {
--         'nvim-tree/nvim-tree.lua',
--         dependencies = {
--             'nvim-tree/nvim-web-devicons', -- опционально, для иконок
--         },
--         config = function()
--             -- отключаем netrw в пользу nvim-tree
--             vim.g.loaded_netrw = 1
--             vim.g.loaded_netrwPlugin = 1
--
--             require('nvim-tree').setup({
--                 sort_by = "case_sensitive",
--                 view = {
--                     width = 30, -- ширина окна с деревом
--                     adaptive_size = true,
--                 },
--                 renderer = {
--                     root_folder_label = false,
--                     highlight_git = true,
--                     group_empty = true,
--                     indent_markers = {
--                         enable = true,
--                         inline_arrows = true,
--                         icons = {
--                             corner = "└",
--                             edge = "│",
--                             item = "│",
--                             bottom = "─",
--                             none = " ",
--                         },
--
--                     },
--                     icons = {
--                         show = {
--                             file = true,
--                             folder = true,
--                             folder_arrow = true,
--                             git = true,
--                         },
--                     },
--                 },
--                 filters = {
--                     dotfiles = true, -- показывать скрытые файлы
--                 },
--                 git = {
--                     enable = true,  -- включить интеграцию с git
--                     ignore = false, -- не игнорировать файлы из .gitignore
--                 },
--                 actions = {
--                     open_file = {
--                         quit_on_open = true, -- не закрывать дерево при открытии файла
--                         window_picker = {
--                             enable = true,
--                         },
--                     },
--                 },
--             })
--
--             -- Настройка горячих клавиш
--             vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true })    -- Ctrl+n для открытия/закрытия
--             vim.keymap.set('n', '<leader>e', ':NvimTreeFocus<CR>', { silent = true }) -- <leader>e для фокуса на дереве
--         end,
--     },
-- }
--
--
--
--
return { {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            source_selector = {
                winbar = false, -- Показывать в winbar (строка вверху окна)
                statusline = false, -- Не показывать в строке статуса
                show_scrolled_off_parent_node = true, -- Показывать родительский узел
                sources = { -- Список источников и их конфигурация
                    {
                        source = "filesystem", -- Файловая система
                        display_name = " 󰉓 Files " -- Имя с иконкой
                    },
                    {
                        source = "buffers", -- Буферы (открытые файлы)
                        display_name = " 󰈙 Buffers "
                    },
                    {
                        source = "git_status", -- Git статус
                        display_name = " 󰊢 Git "
                    },
                    {
                        source = "diagnostics", -- Диагностика (ошибки, предупреждения)
                        display_name = " 󰒡 Diagnostics "
                    },
                },
                separator = { left = "▏", right = "▕" }, -- Разделители вкладок
                color = { -- Цветовая схема
                    fg = "#c3ccdc", -- Цвет текста
                    bg = "#22262e", -- Цвет фона
                    selected = { -- Цвета для выбранной вкладки
                        fg = "#ffffff",
                        bg = "#3a454e",
                    }
                },
            },
            close_if_last_window = true,
            filesystem = {
                visible = true,          -- Отображение фильтрованных элементов в списке
                hide_dotfiles = false,   -- Не скрывать файлы, начинающиеся с точки
                hide_gitignored = false, -- Не скрывать файлы, игнорируемые Git
                hide_hidden = false,     -- Не скрывать скрытые файлы (но показывать их затененными)
                follow_current_file = {
                    enabled = true,
                },
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
                use_libuv_file_watcher = true, -- Использовать файловый watcher библиотеки libuv (быстрее)

            },
            git_status = {
                window = {
                    position = "float",
                    mappings = {
                        ["A"]  = "git_add_all",
                        ["gu"] = "git_unstage_file",
                        ["ga"] = "git_add_file",
                        ["gr"] = "git_revert_file",
                        ["gc"] = "git_commit",
                        ["gp"] = "git_push",
                        ["gg"] = "git_commit_and_push",
                        ["o"]  = "open",
                    }
                }
            },
            buffers = {
                follow_current_file = {
                    enabled = true,      -- Авто-фокус на текущем буфере
                },
                show_unloaded = true,    -- Показывать и выгруженные буферы
                group_empty_dirs = true, -- Группировать пустые директории в списке буферов
                window = {
                    mappings = {
                        ["bd"] = "buffer_delete", -- Удаление буфера
                    }
                },
            },

        })
        vim.keymap.set("n", "<C-n>", "<cmd>Neotree toggle<CR>", { desc = "Toggle file explorer" })
    end
},
    {
        "stevearc/aerial.nvim",
        config = function()
            require("aerial").setup()
            vim.keymap.set("n", "<leader>ar", "<cmd>AerialNavToggle<CR>", { desc = "Toggle code outline" })
        end
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
