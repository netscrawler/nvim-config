return {
	"nvimdev/lspsaga.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
	lazy = false,
	config = function()
		require("lspsaga").setup({
			implement = {
				enable = true, -- Включение отображения имплементации
				sign = false,
				virtual_text = false,
			},
			definition = {
				keys = {
					edit = "o",
				},
			},
			lightbulb = {
				enable = false,
			},
			finder = {
				max_height = 0.6,
				keys = {
					vsplit = "v",
				},
			},
			symbol_in_winbar = {
				enable = false,
			},
			outline = {
				-- layout = 'float'
				win_width = 40,
			},
			code_action = {
				show_server_name = true,
				extend_gitsigns = true,
				enabled = true,
			},
		})
	end,
}
