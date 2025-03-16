-- lua/plugins/rainbow.lua
return {
    "p00f/nvim-ts-rainbow",
    config = function()
        require("nvim-treesitter.configs").setup({
            rainbow = {
                enable = true,
                extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                max_file_lines = nil,  -- Do not enable for files with more than n lines, int
            },
        })
    end,
}
