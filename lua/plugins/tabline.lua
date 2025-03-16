return {
    'kdheepak/tabline.nvim',
    config = function()
        require('tabline').setup {
            enabled = true,
            show_tabs_always = false,
            show_devicons = true,
            show_buffers = true,
            show_filename = true,
            show_index = true,
            modified_icon = '●',
            close_icon = '×',
            icon_pinned = '📌',
            highlights = {
                tab = {
                    fg = '#ffffff',
                    bg = '#1f1f1f',
                    bold = true,
                },
                tab_close = {
                    fg = '#ff0000',
                },
                tab_separator = {
                    fg = '#333333',
                },
            },
            tabline_suffix = ' →',
            max_length = 25,
            close_button = true,
            close_button_on_left = false,
            autocmds = true,
            sort = 'last_modified',
            bufnames = {
                ['python'] = true,
                ['text'] = true,
                ['markdown'] = false,
            }
        }
    end,
    requires = { 'hoob3rt/lualine.nvim', 'kyazdani42/nvim-web-devicons' }
}
