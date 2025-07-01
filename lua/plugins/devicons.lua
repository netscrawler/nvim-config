return {
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				color_icons = true,
				default = true, -- Включить иконки по умолчанию
				strict = true,
			})
		end,
	},
	{
		"echasnovski/mini.icons",
		version = "*",
		config = function()
			require("mini.icons").setup({})
		end,
	},
}
