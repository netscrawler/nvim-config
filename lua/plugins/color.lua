return {
    "brenoprata10/nvim-highlight-colors",
    opts = {
        render = "virtual",
        enable_named_colors = true,
        enable_tailwind = true,
        ---Set virtual symbol (requires render to be set to 'virtual')
        virtual_symbol = '■',

        ---Set virtual symbol suffix (defaults to '')
        virtual_symbol_prefix = '',

        ---Set virtual symbol suffix (defaults to ' ')
        virtual_symbol_suffix = ' ',
    },
}
