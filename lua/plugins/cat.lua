-- lua/plugins/catppuccin.lua
return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		local catppuccin = require("catppuccin")
		catppuccin.setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha

			background = { -- :h background
			},
			transparent_background = true, -- Make the background transparent
			show_end_of_buffer = false, -- Show the '~' characters after the end of buffers
			term_colors = true, -- Set terminal colors (true/false)
			dim_inactive = {
				enabled = false, -- Dim inactive buffer/window/tab
				shade = "dark",
				percentage = 0.15, -- percentage of the shade to apply to the inactive window
			},
			no_italic = false, -- Force no italic
			no_bold = false, -- Force no bold
			styles = { -- The styles that are applied to different syntax groups
				comments = { "italic" },
				conditionals = { "italic" },
				loops = { "bold" },
				functions = { "italic" },
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
			},
			color_overrides = {},
			custom_highlights = function()
				local C = require("catppuccin.palettes").get_palette()
				return {
					GitGraphHash = { fg = C.mauve },
					GitGraphTimestamp = { fg = C.lavender },
					GitGraphAuthor = { fg = C.flamingo },
					GitGraphBranchName = { fg = C.teal },
					GitGraphBranchTag = { fg = C.pink },
					GitGraphBranchMsg = { fg = C.overlay2 },
					GitGraphBranch1 = { fg = C.yellow },
					GitGraphBranch2 = { fg = C.pink },
					GitGraphBranch3 = { fg = C.sky },
					GitGraphBranch4 = { fg = C.green },
					GitGraphBranch5 = { fg = C.red },
				}
			end,
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				telescope = true,
				notify = true,
				aerial = true,
				neotest = true,
				barbar = true,
				mini = false,
				diffview = true,
				fzf = true,
				mason = true,
				snacks = {
					enabled = true,
					indent_scope_color = "mocha", -- catppuccin color (eg. `lavender`) Default: text
				},
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
						ok = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
						ok = { "underline" },
					},
					inlay_hints = {
						background = true,
					},
				},
				nvim_surround = true,
				treesitter_context = true,

				treesitter = true,
				octo = true,
				symbols_outline = true,
				lsp_trouble = true,
				illuminate = false,
				-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#supported-plugins)
			},
		})

		-- Apply the catppuccin theme
	end,
}
