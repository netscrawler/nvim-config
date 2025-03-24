return {
    'nvimdev/lspsaga.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons',     -- optional
    },
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


        })
    end,
}
