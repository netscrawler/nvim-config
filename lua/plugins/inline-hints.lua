return {
    "MysticalDevil/inlay-hints.nvim",
    event = "LspAttach",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
        require("inlay-hints").setup({
            commands = { enable = true }, -- Enable InlayHints commands, include `InlayHintsToggle`, `InlayHintsEnable` and `InlayHintsDisable`
            autocmd = { enable = true },  -- Enable the inlay hints on `LspAttach` event
            -- Используем встроенный рендерер вместо EOL
            renderer = "inlay-hints/render/inline",
            hints = {
                parameter = {
                    show = true,
                    highlight = "InlayHints",
                },
                type = {
                    show = true,
                    highlight = "InlayHints",
                },
                interface = {
                    show = true,
                    highlight = "InlayHints"
                }
            },
            -- Настройки для inline отображения
            inline = {
                -- Префикс для подсказок параметров
                prefix = " <- ",
                -- Настройки отображения типов
                type = {
                    format = function(hint)
                        return string.format(": %s", hint)
                    end
                },
                -- Настройки отображения параметров
                parameter = {
                    format = function(hint)
                        return string.format("(%s)", hint)
                    end
                }
            }
        })
    end
}
