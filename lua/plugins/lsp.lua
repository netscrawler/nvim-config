return {
    -- LSP Configuration
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- LSP and completion dependencies
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "uga-rosa/cmp-cmdline",
            "onsails/lspkind.nvim",

            -- -- Snippet support
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",

            -- Formatting
            "stevearc/conform.nvim",

            -- Go-specific tools
            "maxandron/goplements.nvim",
            -- "Snikimonkd/cmp-go-pkgs",

            -- Additional completion sources
            "f3fora/cmp-spell",
            "petertriho/cmp-git",
            "uga-rosa/cmp-dictionary",

            -- UI enhancements
            "j-hui/fidget.nvim",
            "nvim-treesitter/nvim-treesitter",

            -- Additional tools
            "kndndrj/nvim-dbee",
            "antosha417/nvim-lsp-file-operations",
            -- "Exafunction/codeium.nvim", -- Commented out AI assistant
            {
                "MattiasMTS/cmp-dbee",
                dependencies = {
                    { "kndndrj/nvim-dbee" },
                },
                ft = "sql", -- optional but good to have
                opts = {},  -- needed
            },
        },
        config = function()
            -- Set up Mason for LSP server management
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "gopls",
                },
                automatic_installation = true,
            })

            -- Set up Conform for formatting
            require("conform").setup({
                formatters_by_ft = {
                    go = { "golines", "goimports", "gofumpt", "gci" },
                    lua = { "stylua", "luaformatter" },
                    shell = { "beautysh" },
                    proto = { "buf" },
                },
                format_on_save = {
                    timeout_ms = 500,
                    lsp_fallback = true,
                },
            })

            -- Set up LSP completion
            local cmp = require("cmp")
            local cmp_lsp = require("cmp_nvim_lsp")
            local lspkind = require("lspkind")
            local luasnip = require("luasnip")

            -- Load snippets from friendly-snippets
            require("luasnip.loaders.from_vscode").lazy_load()

            -- Enhanced capabilities for LSP
            local capabilities = vim.tbl_deep_extend(
                "force",
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities(),
                require("lsp-file-operations").default_capabilities()
            )

            -- Add advanced capabilities
            capabilities.textDocument.codeLens = {
                dynamicRegistration = true,
            }
            capabilities.workspace = {
                didChangeWatchedFiles = {
                    dynamicRegistration = true,
                },
            }
            capabilities.textDocument.inlayHint = {
                dynamicRegistration = true,
            }
            capabilities.textDocument.hover = {
                dynamicRegistration = true,
                contentFormat = { "markdown", "plaintext" },
            }
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            -- Set up server-specific configurations
            local lspconfig = require("lspconfig")

            -- General LSP server setup function
            local function setup_server(server_name, config)
                lspconfig[server_name].setup(vim.tbl_deep_extend("force", {
                    capabilities = capabilities,
                }, config or {}))
            end

            -- Configure specific servers
            setup_server("lua_ls", {
                settings = {
                    Lua = {
                        runtime = { version = "Lua 5.1" },
                        diagnostics = {
                            globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                        },
                    },
                },
            })

            setup_server("dockerls")
            setup_server("docker_compose_language_service")

            local diagnostic_signs = {
                [vim.diagnostic.severity.ERROR] = "",
                [vim.diagnostic.severity.WARN] = "",
                [vim.diagnostic.severity.INFO] = "",
                [vim.diagnostic.severity.HINT] = "󰌵",
            }

            local function diagnostic_format(diagnostic)
                return string.format(
                    "%s %s: %s",
                    diagnostic_signs[diagnostic.severity],
                    -- shorter_source_names[diagnostic.source] or diagnostic.source,
                    diagnostic.code,
                    diagnostic.message
                )
            end

            vim.diagnostic.config({
                virtual_text = {
                    spacing = 10,
                    prefix = "",
                    format = diagnostic_format,
                },
                signs = {
                    text = diagnostic_signs,
                },
                -- virtual_lines = {
                -- 	current_line = true,
                -- },
                underline = true,
                severity_sort = false,
            })

            -- Set up nvim-cmp
            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp",       priority = 1000 },
                    { name = "luasnip",        priority = 750 },
                    { name = "goplements",     priority = 700 },
                    { name = "vim-go",         priority = 600 },
                    { name = "path",           priority = 500 },
                    { name = "buffer",         priority = 400 },
                    { name = "git" },
                    { name = "dictionary" },
                    { name = "nvim_treesitter" },
                    { name = "cmp-dbee" },
                    { name = "spell" },
                }),
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        ellipsis_char = "...",
                        menu = {
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snippet]",
                            buffer = "[Buffer]",
                            path = "[Path]",
                            goplements = "[Go]",
                            go_pkgs = "[GoPkg]",
                        },
                    })
                },
                experimental = {
                    ghost_text = true,
                },
            })

            -- Set up completion for command mode
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                    { name = "cmdline" },
                }),
            })

            -- Set up completion for / search
            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })


            -- Refresh codelens when needed
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                callback = function()
                    vim.lsp.codelens.refresh()
                end,
            })
        end,
    },
}
