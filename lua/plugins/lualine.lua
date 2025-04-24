return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "SmiteshP/nvim-navic" },
	config = function()
		-- local navic = require("nvim-navic")
		-- local tabln = require 'tabline'
		require("lualine").setup({
			opts = function(_, opts)
				local trouble = require("trouble")
				local symbols = trouble.statusline({
					mode = "lsp_document_symbols",
					groups = {},
					title = false,
					filter = { range = true },
					format = "{kind_icon}{symbol.name:Normal}",
					-- The following line is needed to fix the background color
					-- Set it to the lualine section you want to use
					hl_group = "lualine_c_normal",
				})
				table.insert(opts.sections.lualine_c, {
					symbols.get,
					cond = symbols.has,
				})
			end,
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = "",
				section_separators = "",
				disabled_filetypes = {
					statusline = {},
					tabline = { "filesystem" },
					winbar = {},
				},
				ignore_focus = { "neo-tree", "telescope", "sidebar" },
				always_divide_middle = true,
				always_show_tabline = true,
				globalstatus = true,
				refresh = {
					statusline = 100,
					tabline = 100,
					winbar = 100,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename", "trouble" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {
				-- lualine_a = {},
				-- lualine_b = {},
				-- lualine_c = { 'buffers' },
				-- lualine_x = {},
				-- lualine_y = {},
				-- lualine_z = { 'tabs' },
			},
			winbar = {},
			extensions = {
				"fugitive",
				"fzf",
				"lazy",
				"mason",
				"nerdtree",
				"quickfix",
				"symbols-outline",
				"toggleterm",
				"trouble",
				"aerial",
				"neo-tree",
				"nvim-dap-ui",
			},
		})
		vim.opt.showmode = false
	end,
}
