-- lua/plugins/todo-comments.lua

return {
    "folke/todo-comments.nvim",
    lazy = true,
    cmd = { "TodoTrouble", "TodoTelescope" },
    config = function()
        require("todo-comments").setup({
            -- Здесь можно настроить параметры плагина по вашему вкусу
            signs = true,      -- показывать значки слева от заметок
            sign_priority = 8, -- приоритет значков (чем выше, тем ближе к верху)
            keywords = {
                TODO = { icon = " ", color = "warning" },
                NOTE = { icon = " ", color = "hint" },
                FIXME = { icon = " ", color = "error" },
            },
            highlight = {
                before = "",    -- текст перед ключевым словом
                keyword = "bg", -- стиль ключевого слова
                after = "fg",   -- текст после ключевого слова
            },
        })
    end,
}
