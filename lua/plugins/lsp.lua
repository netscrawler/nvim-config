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
            -- "L3MON4D3/LuaSnip",
            -- "saadparwaiz1/cmp_luasnip",
            -- 'rafamadriz/friendly-snippets',

            -- Formatting
            "stevearc/conform.nvim",

            -- Go-specific tools
            'maxandron/goplements.nvim',
            -- "Snikimonkd/cmp-go-pkgs",

            -- Additional completion sources
            'f3fora/cmp-spell',
            'petertriho/cmp-git',
            'uga-rosa/cmp-dictionary',

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
                    { "kndndrj/nvim-dbee" }
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
                    "html",
                    "cssls",
                    "cssmodules_ls",
                    "emmet_ls"
                    -- "golangci_lint_ls"
                },
            })

            -- Set up Conform for formatting
            require("conform").setup({
                formatters_by_ft = {
                    go = { "goimports", "gofumpt", "golines" },
                    lua = { "stylua" },
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    html = { "prettier" },
                    css = { "prettier" },
                    json = { "prettier" },
                    yaml = { "prettier" },
                    markdown = { "prettier" },
                },
                format_on_save = {
                    timeout_ms = 500,
                    lsp_fallback = true,
                }
            })

            -- Set up LSP completion
            local cmp = require("cmp")
            local cmp_lsp = require("cmp_nvim_lsp")
            local lspkind = require("lspkind")
            -- local luasnip = require("luasnip")

            -- Load snippets from friendly-snippets
            -- require("luasnip.loaders.from_vscode").lazy_load()

            -- Enhanced capabilities for LSP
            local capabilities = vim.tbl_deep_extend(
                "force",
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities()
            )

            -- Add advanced capabilities
            capabilities.textDocument.codeLens = {
                dynamicRegistration = true,
            }
            capabilities.workspace = {
                didChangeWatchedFiles = {
                    dynamicRegistration = true
                }
            }
            capabilities.textDocument.inlayHint = {
                dynamicRegistration = true
            }
            capabilities.textDocument.hover = {
                dynamicRegistration = true,
                contentFormat = { "markdown", "plaintext" }
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
                        }
                    }
                }
            })
            -- lspconfig.golangci_lint_ls.setup({
            --     capabilities = capabilities,
            --     root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
            --     filetypes = { "go" },
            --     init_options = {
            --         command = { "golangci-lint", "run", "--out-format", "json" },
            --     },
            -- })
            -- setup_server("golangci_lint_ls", {
            --
            --     settings = {
            --         root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
            --         filetypes = { "go" },
            --         init_options = {
            --             command = { "golangci-lint", "run", "--out-format", "json" },
            --         },
            --     }
            --
            -- })

            setup_server("gopls", {
                settings = {
                    gopls = {
                        analyses = {
                            fieldalignment = true,
                            framepointer = true,
                            sigchanyzer = true,
                            unreachable = true,
                            stdversion = true,
                            unusedparams = true,
                            unusedwrite = true,
                            useany = true,
                            nilness = true,
                            shadow = true,
                            unusedvariable = true,
                            modernize = true,
                        },
                        staticcheck = true,
                        gofumpt = true,
                        directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                        codelenses = {
                            gc_details = true,
                            generate = true,
                            regenerate_cgo = true,
                            run_govulncheck = true,
                            test = true,
                            tidy = true,
                            upgrade_dependency = true,
                            vendor = true,
                        },
                        hints = {
                            assignVariableTypes = true,
                            compositeLiteralFields = true,
                            compositeLiteralTypes = true,
                            constantValues = true,
                            functionTypeParameters = true,
                            parameterNames = true,
                            rangeVariableTypes = true,
                            compositeLiteralFieldSnippets = true,
                            allStructFields = true,
                            parameterType = true,
                            emptyFields = true,
                        },
                        linksInHover = true,
                        semanticTokens = true,
                        experimentalWorkspaceModule = true,
                        experimentalPostfixCompletions = true,

                        completeUnexported = true,
                        completionProvider = {
                            triggerCharacters = { ".", ":", "/", " ", "(", "*", "&" }
                        }
                    },
                }
            })

            setup_server("html", {
                filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
                init_options = {
                    configurationSection = { "html", "css", "javascript" },
                    embeddedLanguages = {
                        css = true,
                        javascript = true,
                    },
                }
            })

            setup_server("cssls", {
                filetypes = { "css", "scss", "less" },
            })

            setup_server("cssmodules_ls", {
                filetypes = { "css", "scss", "less" },
            })

            setup_server("emmet_ls", {
                filetypes = { "html", "css", "scss", "less" },
            })

            -- Set up diagnostic signs
            local signs = {
                Error = "✘",
                Warn = "▲",
                Info = "ℹ",
                Hint = "⚑"
            }

            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl })
            end

            -- Configure diagnostics
            vim.diagnostic.config({
                update_in_insert = true,
                virtual_text = { source = "always" },
                signs = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })

            -- Set up nvim-cmp
            cmp.setup({
                -- snippet = {
                --     expand = function(args)
                --         luasnip.lsp_expand(args.body)
                --     end,
                -- },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp',       priority = 1000 },
                    -- { name = 'luasnip',        priority = 750 },
                    { name = 'goplements',     priority = 700 },
                    -- { name = 'go_pkgs',        priority = 600 },
                    { name = 'path',           priority = 500 },
                    { name = 'buffer',         priority = 400 },
                    { name = 'git' },
                    { name = 'dictionary' },
                    { name = 'nvim_treesitter' },
                    { name = 'cmp-dbee' },
                    { name = 'spell' },
                    -- { name = 'codeium' },
                }),
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol_text',
                        maxwidth = 50,
                        ellipsis_char = '...',
                        menu = {
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snippet]",
                            buffer = "[Buffer]",
                            path = "[Path]",
                            goplements = "[Go]",
                            go_pkgs = "[GoPkg]",
                        },
                    }),
                },
                experimental = {
                    ghost_text = true,
                }
            })

            -- Set up completion for command mode
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' },
                    { name = 'cmdline' }
                })
            })

            -- Set up completion for / search
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Set up Go-specific tools and commands
            local function setup_go_code_actions()
                local function execute_action(filter)
                    local bufnr = vim.api.nvim_get_current_buf()
                    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
                    row = row - 1

                    local params = {
                        textDocument = {
                            uri = vim.uri_from_bufnr(bufnr)
                        },
                        range = {
                            start = { line = row, character = col },
                            ["end"] = { line = row, character = col }
                        },
                        context = {
                            diagnostics = vim.diagnostic.get(bufnr),
                            only = filter
                        }
                    }

                    vim.lsp.buf.code_action(params)
                end

                -- Create commands for Go-specific actions
                vim.api.nvim_create_user_command('GoFillStruct', function()
                    execute_action({ 'source.fill_struct' })
                end, { desc = "Fill struct with default values" })

                vim.api.nvim_create_user_command('GoRename', function()
                    vim.lsp.buf.rename()
                end, { desc = "Rename symbol with gopls" })

                vim.api.nvim_create_user_command('GoImplement', function()
                    execute_action({ 'source.impl' })
                end, { desc = "Implement interface" })

                vim.api.nvim_create_user_command('GoAddTags', function()
                    execute_action({ 'source.addTags' })
                end, { desc = "Add struct tags" })

                vim.api.nvim_create_user_command('GoRemoveTags', function()
                    execute_action({ 'source.removeTags' })
                end, { desc = "Remove struct tags" })

                vim.api.nvim_create_user_command('GoIfErr', function()
                    execute_action({ 'source.addIfErr' })
                end, { desc = "Add if err check" })

                vim.api.nvim_create_user_command('GoExtractFunction', function()
                    execute_action({ 'source.extractFunction' })
                end, { desc = "Extract function" })

                vim.api.nvim_create_user_command('GoExtractVariable', function()
                    execute_action({ 'source.extractVariable' })
                end, { desc = "Extract variable" })

                vim.api.nvim_create_user_command('GoAddTest', function()
                    execute_action({ 'source.addTest' })
                end, { desc = "Add test for function" })

                vim.api.nvim_create_user_command('GoAddAllTests', function()
                    execute_action({ 'source.addAllTests' })
                end, { desc = "Add tests for all functions" })

                vim.api.nvim_create_user_command('GoFixImports', function()
                    vim.lsp.buf.execute_command({
                        command = "gopls.tidy",
                        arguments = { vim.api.nvim_buf_get_name(0) }
                    })
                end, { desc = "Fix imports" })

                -- Key mappings for Go development
                vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, { desc = "Run code lens" })
                -- vim.keymap.set('n', '<leader>cA', function() vim.lsp.buf.code_action() end, { desc = 'Code actions' })
                vim.keymap.set('n', '<leader>rt', ':GoAddTags<CR>', { desc = 'Add tags' })
                vim.keymap.set('n', '<leader>rT', ':GoRemoveTags<CR>', { desc = 'Remove tags' })
                vim.keymap.set('n', '<leader>re', ':GoIfErr<CR>', { desc = 'Add if err' })
                vim.keymap.set('n', '<leader>ta', ':GoAddTest<CR>', { desc = 'Add test' })
                vim.keymap.set('n', '<leader>tA', ':GoAddAllTests<CR>', { desc = 'Add all tests' })
                vim.keymap.set('n', '<leader>fi', ':GoFixImports<CR>', { desc = 'Fix imports' })
            end

            setup_go_code_actions()

            -- Refresh codelens when needed
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                callback = function()
                    vim.lsp.codelens.refresh()
                end,
            })

            -- Format HTML and CSS files on save
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = { "*.html", "*.css" },
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end
    } }
