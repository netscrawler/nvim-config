return {
	{
		"fatih/vim-go",
		ft = { "go", "gomod", "gowork", "gotmpl" }, -- Lazy load only for Go files
		build = ":GoUpdateBinaries",
		config = function()
			-- Disable features that overlap with gopls to avoid conflicts
			vim.g.go_gopls_enabled = 0 -- Disable gopls in vim-go since we use native LSP
			vim.g.go_code_completion_enabled = 0 -- Disable code completion in vim-go
			vim.g.go_def_mapping_enabled = 0 -- Disable default mapping in vim-go
			vim.g.go_doc_keywordprg_enabled = 0 -- Disable K mapping

			-- Keep useful vim-go features that work well with LSP
			vim.g.go_fmt_command = "goimports" -- Use goimports for formatting
			vim.g.go_fmt_autosave = 1 -- Auto format on save
			vim.g.go_imports_autosave = 1 -- Auto manage imports on save
			vim.g.go_mod_fmt_autosave = 1 -- Auto format go.mod

			-- Syntax highlighting
			vim.g.go_highlight_types = 1
			vim.g.go_highlight_fields = 1
			vim.g.go_highlight_functions = 1
			vim.g.go_highlight_function_calls = 1
			vim.g.go_highlight_operators = 1
			vim.g.go_highlight_extra_types = 1
			vim.g.go_highlight_build_constraints = 1
			vim.g.go_highlight_generate_tags = 1
			vim.g.go_highlight_variable_declarations = 1
			vim.g.go_highlight_variable_assignments = 1
			vim.g.go_snippet_engine = "automatic"

			-- Testing features (which are not covered by gopls)
			vim.g.go_test_timeout = "10s"
			vim.g.go_test_show_name = 1

			-- More compact and focused key mappings for vim-go specific features
			local function map(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
			end

			-- Testing commands
			map("n", "<leader>gt", "<cmd>GoTest<CR>", "Go Run Tests")
			map("n", "<leader>gc", "<cmd>GoCoverage<CR>", "Go Show Coverage")
			map("n", "<leader>gct", "<cmd>GoCoverageToggle<CR>", "Go Toggle Coverage")

			-- Build and run
			map("n", "<leader>`", "<cmd>GoRun<CR>", "Go Run")

			-- Alternate between implementation and test
			map("n", "<leader>ga", "<cmd>GoAlternate<CR>", "Go to Alternate File")

			-- -- Set Go-specific options
			-- vim.api.nvim_create_autocmd("FileType", {
			--     pattern = "go",
			--     callback = function()
			--         vim.opt_local.expandtab = false -- Use tabs not spaces
			--         vim.opt_local.tabstop = 4
			--         vim.opt_local.shiftwidth = 4
			--     end,
			-- })
		end,
	},
	{
		"j-hui/fidget.nvim",
		opts = {
			notification = {
				window = {
					winblend = 0,
				},
			},
		},
	},
}
