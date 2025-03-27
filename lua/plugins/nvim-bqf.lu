return {
    "kevinhwang91/nvim-bqf",
    ft = "qf", -- Загружать только в quickfix окне
    config = function()
        require("bqf").setup({
            auto_enable = true,        -- Автоматически включать bqf
            auto_resize_height = true, -- Автоматически изменять высоту quickfix-окна
            preview = {
                win_height = 12,       -- Высота окна предпросмотра
                win_vheight = 12,
                delay_syntax = 50,     -- Задержка перед подсветкой
                border_chars = { '│', '│', '─', '─', '╭', '╮', '╯', '╰' }
            },
            func_map = {
                open = '<CR>',     -- Открывать элемент из quickfix списка
                openc = 'o',       -- Открывать в новой вкладке
                split = '<C-x>',   -- Открывать в сплите
                vsplit = '<C-v>',  -- Открывать в вертикальном сплите
                tabdrop = '<C-t>', -- Открывать в новой вкладке
                tabc = '',         -- Закрытие вкладки
                prevfile = 'K',    -- Переключаться к предыдущему файлу
                nextfile = 'J'     -- Переключаться к следующему файлу
            },
            filter = {
                fzf = {
                    extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " }
                }
            }
        })
    end
}
