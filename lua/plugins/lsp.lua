return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "onsails/lspkind.nvim",
        "stevearc/conform.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "Exafunction/codeium.nvim",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        'f3fora/cmp-spell',
        'maxandron/goplements.nvim', -- Исправлена структура зависимостей
        "kndndrj/nvim-dbee",
        'petertriho/cmp-git',
        'uga-rosa/cmp-dictionary',
        'nvim-treesitter/nvim-treesitter',
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        'rafamadriz/friendly-snippets',
        "j-hui/fidget.nvim",
        "uga-rosa/cmp-cmdline",
        "Snikimonkd/cmp-go-pkgs",
    },
    config = function()
        -- Настройка Conform
        require("conform").setup({
            formatters_by_ft = {
                go = { "goimports", "gofumpt" },
            }
        })

        -- nvim-cmp
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        -- Исправленный CodeLens
        capabilities.textDocument.codeLens = {
            dynamicRegistration = true,
        }


        -- Mason
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "gopls",
                "html",
                "cssls",
                "cssmodules_ls",
                "emmet_ls"
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
                ["html"] = function()
                    require("lspconfig").html.setup {
                        capabilities = capabilities,
                        filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
                        init_options = {
                            configurationSection = { "html", "css", "javascript" },
                            embeddedLanguages = {
                                css = true,
                                javascript = true,
                            },
                        },
                    }
                end,
                ["cssls"] = function()
                    require("lspconfig").cssls.setup {
                        capabilities = capabilities,
                        filetypes = { "css", "scss", "less" },
                    }
                end,
                ["cssmodules_ls"] = function()
                    require("lspconfig").cssmodules_ls.setup {
                        capabilities = capabilities,
                        filetypes = { "css", "scss", "less" },
                    }
                end,
                ["emmet_ls"] = function()
                    require("lspconfig").emmet_ls.setup {
                        capabilities = capabilities,
                        filetypes = { "html", "css", "scss", "less" },
                    }
                end,
                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
                ["gopls"] = function()
                    require("lspconfig").gopls.setup {
                        capabilities = capabilities,
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
                                experimentalPostfixCompletions = true,
                            },
                        },
                    }
                end
            },
        })
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = { "*.html", "*.css" },
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
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
                        diagnostics = vim.diagnostic.get(bufnr), -- Исправлено API
                        only = filter
                    }
                }

                vim.lsp.buf.code_action(params)
            end
            vim.api.nvim_create_user_command('GoFillStruct', function()
                execute_action({ 'source.fill_struct' })
            end, { desc = "Fill struct with default values" })

            vim.api.nvim_create_user_command('GoRename', function()
                vim.lsp.buf.rename()
            end, { desc = "Rename symbol with gopls" })
            vim.api.nvim_create_user_command('GoImplement', function()
                execute_action({ 'source.impl' })
            end, {})

            vim.api.nvim_create_user_command('GoAddTags', function()
                execute_action({ 'source.addTags' })
            end, {})

            vim.api.nvim_create_user_command('GoRemoveTags', function()
                execute_action({ 'source.removeTags' })
            end, {})

            vim.api.nvim_create_user_command('GoIfErr', function()
                execute_action({ 'source.addIfErr' })
            end, {})

            vim.api.nvim_create_user_command('GoExtractFunction', function()
                execute_action({ 'source.extractFunction' })
            end, {})

            vim.api.nvim_create_user_command('GoExtractVariable', function()
                execute_action({ 'source.extractVariable' })
            end, {})

            vim.api.nvim_create_user_command('GoAddTest', function()
                execute_action({ 'source.addTest' })
            end, {})

            vim.api.nvim_create_user_command('GoAddAllTests', function()
                execute_action({ 'source.addAllTests' })
            end, {})

            vim.api.nvim_create_user_command('GoFixImports', function()
                vim.lsp.buf.execute_command({
                    command = "gopls.tidy", -- Исправлена команда для Go
                    arguments = { vim.api.nvim_buf_get_name(0) }
                })
            end, {})

            -- Keymaps
            vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, { desc = 'Code actions' })
            vim.keymap.set('n', '<leader>rt', ':GoAddTags<CR>', { desc = 'Add tags' })
            vim.keymap.set('n', '<leader>rT', ':GoRemoveTags<CR>', { desc = 'Remove tags' })
            vim.keymap.set('n', '<leader>re', ':GoIfErr<CR>', { desc = 'Add if err' })
            vim.keymap.set('n', '<leader>ta', ':GoAddTest<CR>', { desc = 'Add test' })
            vim.keymap.set('n', '<leader>tA', ':GoAddAllTests<CR>', { desc = 'Add all tests' })
            vim.keymap.set('n', '<leader>fi', ':GoFixImports<CR>', { desc = 'Fix imports' })
        end
        setup_go_code_actions()

        -- Значки диагностики
        vim.fn.sign_define("DiagnosticSignError", { text = "✘", texthl = "DiagnosticSignError" })
        vim.fn.sign_define("DiagnosticSignWarn", { text = "▲", texthl = "DiagnosticSignWarn" })
        vim.fn.sign_define("DiagnosticSignInfo", { text = "ℹ", texthl = "DiagnosticSignInfo" })
        vim.fn.sign_define("DiagnosticSignHint", { text = "⚑", texthl = "DiagnosticSignHint" })

        -- nvim-cmp
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'codeium' },
                { name = 'nvim_lsp' },
                { name = 'goplements' },
                { name = 'luasnip' },
                { name = 'path' },
                { name = 'omni' },
                { name = 'git' },
                { name = 'dictionary' },
                { name = 'nvim_treesitter' },
                { name = 'go_pkgs' },
                { name = 'cmp-dbee' },
            }, {
                { name = 'buffer' },
            }),
            formatting = {
                format = function(entry, vim_item)
                    local icons = {
                        Text = "",
                        Method = "",
                        Function = "",
                        Constructor = "",
                        Field = "",
                        Variable = "",
                        Class = "",
                        Interface = "",
                        Module = "",
                        Property = "",
                        Unit = "",
                        Value = "",
                        Enum = "",
                        Keyword = "",
                        Snippet = "",
                        Color = "",
                        File = "",
                        Reference = "",
                        Folder = "",
                        EnumMember = "",
                        Constant = "",
                        Struct = "",
                        Event = "",
                        Operator = "",
                        TypeParameter = "",
                    }
                    vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
                    return vim_item
                end,
            },
            experimental = {
                ghost_text = true,
            }
        })

        -- Дополнительные настройки
        vim.keymap.set('n', '<leader>so', ':SymbolsOutline<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { noremap = true, silent = true })

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
    end
}
