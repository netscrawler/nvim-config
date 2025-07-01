return {
	"mrcjkb/rustaceanvim",
	version = "^6",
	lazy = false,
	ft = { "rust" },
	config = function()
		vim.g.rustaceanvim = {
			tools = {
				runnables = {
					use_telescope = true,
				},
				inlay_hints = {
					auto = true,
					show_parameter_hints = true,
					parameter_hints_prefix = "",
					other_hints_prefix = "",
				},
			},
			server = {

				default_settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							runBuildScripts = true,
						},
						checkOnSave = {
							command = "clippy",
						},
						procMacro = {
							enable = true,
						},
						diagnostics = {
							enable = true,
							enableExperimental = true,
							disabled = { "unresolved-proc-macro" },
						},
					},
				},
			},
			dap = {
				-- Настройки отладки, если используешь DAP
			},
		}
	end,
}
