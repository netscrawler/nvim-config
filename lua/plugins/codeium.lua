-- файл: ~/.config/nvim/lua/plugins/codeium.lua
return {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = function()
        require("codeium").setup({
            key_bindings = {
                -- Accept the current completion.
                accept = "<C-y>",
                -- Accept the next word.
                accept_word = false,
                -- Accept the next line.
                accept_line = false,
                -- Clear the virtual text.
                clear = false,
                -- Cycle to the next completion.
                next = "<C-n>",
                -- Cycle to the previous completion.
                prev = "<C-p>",
            }
        })
    end,
}
