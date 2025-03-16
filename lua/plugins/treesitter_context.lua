-- lua/plugins.lua
return {
    {
        'nvim-treesitter/nvim-treesitter-context',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        config = function()
            require('treesitter-context').setup {
                enable = true,        -- включить или выключить плагин
                max_lines = 15,       -- сколько строк контекста показывать
                trim_scope = 'inner', -- как обрезать контекст ('inner' или 'outer')
                patterns = {          -- какие паттерны использовать для определения контекста
                    default = {
                        'class',
                        'function',
                        'method',
                        'for',
                        'while',
                        'if',
                        'switch',
                        'case',
                    },
                    go = {
                        'function_definition',
                        'method_declaration',
                    },
                },
                exact_patterns = {},
                zindex = 20,     -- порядок отображения окна контекста
                mode = 'cursor', -- режим работы ('cursor' или 'topline')
            }
        end,
    },
}
