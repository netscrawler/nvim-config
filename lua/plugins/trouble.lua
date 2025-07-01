return {
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },

		opts = {
			modes = {
				diagnostics = {
					preview = {
						type = "split",
						relative = "win",
						position = "right",
						size = 0.45,
					},
				},
			},
		},
		cmd = { "Trouble", "TroubleToggle" },
		keys = {
			{
				"<leader>dq",
				function()
					local diagnostics = vim.diagnostic.get(nil) -- все диагноза в текущем проекте
					local qf_items = {}

					for _, d in ipairs(diagnostics) do
						local bufnr = d.bufnr or 0
						local filename = vim.api.nvim_buf_get_name(bufnr)
						table.insert(qf_items, {
							filename = filename,
							lnum = d.lnum + 1,
							col = d.col + 1,
							text = d.message,
							type = d.severity == 1 and "E" or d.severity == 2 and "W" or "I",
						})
					end

					vim.fn.setqflist(qf_items, "r")
					vim.cmd("Trouble qflist open")
				end,
				desc = "Populate Quickfix from diagnostics (Trouble)",
			},
			{
				"<leader>q",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>ql",
				function()
					require("trouble").toggle("lsp", { focus = false, win = { position = "right" } })
				end,
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
}
