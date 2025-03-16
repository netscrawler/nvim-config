return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup({
                -- Настройки
                size = 20,
                open_mapping = [[<C-\>]], -- Горячая клавиша для открытия терминала
                direction = "float",      -- Плавающее окно
                float_opts = {
                    border = "curved",    -- Тип границы (curved, single, double и т.д.)
                },
            })
        end,
    },
}
