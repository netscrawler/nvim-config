return {
    'nvimdev/lspsaga.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons',     -- optional
    },
    lazy = false,
    config = function()
        require('lspsaga').setup({
            implement = {
                enable = true, -- Включение отображения имплементации
                sign = true,
                virtual_text = true,
            },
            lightbulb = {
                enable = false
            },
            symbol_in_winbar = {
                enable = false,
            },
            outline = {
                -- layout = 'float'
                win_width = 40
            },
            code_action = {
                enabled = true
            }


        })
    end,
}
