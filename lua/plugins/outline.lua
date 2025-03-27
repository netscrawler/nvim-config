return {
    {
        "hedyhli/outline.nvim",
        lazy = true,
        config = function()
            local opts = {
                highlight_hovered_item = true,
                show_guides = true,
                position = 'right',
                width = 25,
                show_numbers = false,
                show_relative_numbers = false,
                show_symbol_details = true,
                preview_bg_highlight = 'Pmenu',
                auto_preview = true, -- Отключаем auto_preview
                keymaps = {
                    close = "<Esc>",
                    goto_location = "<Cr>",
                    focus_location = "o",
                    hover_symbol = "<C-space>",
                    toggle_preview = "K",
                    rename_symbol = "r",
                    code_actions = "a",
                    fold = "h",
                    unfold = "l",
                    fold_all = "W",
                    unfold_all = "E",
                    fold_reset = "R",
                },
                icons = {
                    -- Функции
                    func = "󰊕", -- Иконка функции
                    -- Классы
                    class = "", -- Иконка класса
                    -- Переменные
                    var = "", -- Иконка переменной
                    -- Интерфейсы
                    interface = "", -- Иконка интерфейса
                    -- Модули
                    module = "󰅩", -- Иконка модуля
                    -- Структуры
                    struct = "", -- Иконка структуры
                    -- Поля
                    field = "", -- Иконка поля
                    -- Константы
                    const = "", -- Иконка константы
                    -- Методы
                    method = "󰆧", -- Иконка метода
                    -- Пространства имен
                    namespace = "󰅪", -- Иконка пространства имен
                    -- Перечисления
                    enum = "󰕘", -- Иконка перечисления
                    -- Элементы перечисления
                    enum_member = "󰕘", -- Иконка элемента перечисления
                    -- Свойства
                    property = "", -- Иконка свойства
                    -- События
                    event = "󰃮", -- Иконка события
                    -- Конструкторы
                    constructor = "", -- Иконка конструктора
                    -- Другие символы
                    default = "󰈚", -- Иконка по умолчанию
                },

            }

            require("outline").setup(opts)


            -- Добавляем маппинг для безопасного открытия
            vim.keymap.set('n', '<leader>no', ':Outline<CR>',
                { noremap = true, silent = true, desc = "Toggle Outline" })
        end,

    }
}
