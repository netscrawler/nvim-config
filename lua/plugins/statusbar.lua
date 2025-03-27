return {
    -- Отображение навигации по файлу (как в GoLand)
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("barbecue").setup({
                theme = "catppuccin",
                show_dirname = false, -- отображать имя директории
                show_basename = false, -- отображать имя файла
                symbols = {
                    separator = " ❯ ", -- символ разделителя
                },
            })
        end,
    },

    -- Вкладки вверху (winbar) с путями (как в GoLand)
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("barbecue").setup({
                theme = "catppuccin",
                show_dirname = true,
                show_basename = true,
            })
        end,
    },
}
