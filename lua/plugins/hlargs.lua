return {
    "m-demare/hlargs.nvim",
    config = function()
        require("hlargs").setup({
            color = "#ef9062",
            use_colorpalette = false,
            disable = function(_, bufnr)
                return vim.bo[bufnr].filetype ~= "go"
            end,
        })
    end,
}

