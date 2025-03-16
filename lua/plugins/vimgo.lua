return {

    {
        -- Основной плагин для Go
        {
            'fatih/vim-go',
            ft = { 'go', 'gomod', 'gowork', 'gotmpl' }, -- ленивая загрузка только для Go файлов
            run = ':GoUpdateBinaries',
            config = function()
                -- Основные настройки
                vim.g.go_fmt_command = 'goimports' -- Используем goimports для форматирования
                vim.g.go_fmt_autosave = 1          -- Автоматическое форматирование при сохранении
                vim.g.go_imports_autosave = 1      -- Автоматическое управление импортами при сохранении
                vim.g.go_mod_fmt_autosave = 1      -- Автоматическое форматирование go.mod

                -- Настройки для gopls
                vim.g.go_gopls_enabled = 1               -- Включаем gopls
                vim.g.go_gopls_options = {               -- Настройки gopls
                    '--remote=auto',                     -- Автоматическое определение удаленного сервера
                    '--remote.debug=:0',                 -- Отключение отладки
                    '--completion.usePlaceholders=true', -- Использование плейсхолдеров при автодополнении
                    '--staticcheck=true',                -- Включение статического анализа
                    '--analyses=true',                   -- Включение всех анализаторов
                }
                vim.g.go_def_mode = 'gopls'              -- Использование gopls для переходов к определениям
                vim.g.go_info_mode = 'gopls'             -- Использование gopls для получения информации

                -- Подсветка синтаксиса
                vim.g.go_highlight_types = 1                     -- Подсветка типов
                vim.g.go_highlight_fields = 1                    -- Подсветка полей
                vim.g.go_highlight_functions = 1                 -- Подсветка функций
                vim.g.go_highlight_function_calls = 1            -- Подсветка вызовов функций
                vim.g.go_highlight_operators = 1                 -- Подсветка операторов
                vim.g.go_highlight_extra_types = 1               -- Подсветка дополнительных типов
                vim.g.go_highlight_build_constraints = 1         -- Подсветка build constraints
                vim.g.go_highlight_generate_tags = 1             -- Подсветка тегов go:generate
                vim.g.go_highlight_variable_declarations = 1     -- Подсветка объявлений переменных
                vim.g.go_highlight_variable_assignments = 1      -- Подсветка присваиваний переменным
                vim.g.go_highlight_array_whitespace_error = 1    -- Подсветка ошибок пробелов в массивах
                vim.g.go_highlight_chan_whitespace_error = 1     -- Подсветка ошибок пробелов в каналах
                vim.g.go_highlight_space_tab_error = 1           -- Подсветка ошибок смешивания пробелов и табуляций
                vim.g.go_highlight_trailing_whitespace_error = 1 -- Подсветка trailing whitespace

                -- Автодополнение и информация
                vim.g.go_auto_type_info = 1 -- Автоматическое отображение типов
                vim.g.go_auto_sameids = 1   -- Подсветка одинаковых идентификаторов
                vim.g.go_echo_go_info = 1   -- Показ информации в командной строке
                vim.g.go_updatetime = 800   -- Задержка обновления (мс)

                -- Тестирование
                vim.g.go_test_timeout = '10s' -- Таймаут для тестов
                vim.g.go_test_show_name = 1   -- Показывать имена тестов
                vim.g.go_test_keymap = 1      -- Включить маппинги для тестов

                -- Маппинги
                local function map(mode, lhs, rhs, opts)
                    local options = { noremap = true, silent = true }
                    if opts then options = vim.tbl_extend('force', options, opts) end
                    vim.keymap.set(mode, lhs, rhs, options)
                end

                -- Основные операции
                map('n', '<leader>`', '<cmd>GoRun<CR>')              -- Запуск программы
                -- map('n', '<leader>gb', '<cmd>GoBuild<CR>')       -- Сборка
                map('n', '<leader>gt', '<cmd>GoTest<CR>')            -- Запуск тестов
                map('n', '<leader>gc', '<cmd>GoCoverage<CR>')        -- Показать покрытие тестами
                map('n', '<leader>gct', '<cmd>GoCoverageToggle<CR>') -- Переключить покрытие
                map('n', '<leader>gin', '<cmd>GoInfo<CR>')           -- Информация о символе
                map('n', '<leader>gm', '<cmd>GoImports<CR>')         -- Управление импортами
                map('n', '<leader>gR', '<cmd>GoRename<CR>')          -- Переименование
                map('n', '<leader>gs', '<cmd>GoFillStruct<CR>')      -- Заполнить структуру
                map('n', '<leader>ge', '<cmd>GoIfErr<CR>')           -- Добавить обработку ошибок

                -- Навигация
                map('n', '<leader>gd', '<cmd>GoDef<CR>')        -- Перейти к определению
                map('n', '<leader>gD', '<cmd>GoDecls<CR>')      -- Показать объявления
                map('n', '<leader>gp', '<cmd>GoDefPop<CR>')     -- Вернуться назад
                map('n', '<leader>gi', '<cmd>GoImplements<CR>') -- Показать интерфейсы

                -- Рефакторинг и документация
                map('n', '<leader>gf', '<cmd>GoFillStruct<CR>')  -- Заполнить структуру
                map('n', '<leader>ga', '<cmd>GoAddTags<CR>')     -- Добавить теги
                map('n', '<leader>grm', '<cmd>GoRemoveTags<CR>') -- Удалить теги
                map('n', '<leader>gK', '<cmd>GoDoc<CR>')         -- Показать документацию

                -- Альтернативные файлы
                map('n', '<leader>ga', '<cmd>GoAlternate<CR>') -- Переключение между файлом и тестом

                -- Дополнительные настройки
                vim.g.go_addtags_transform = 'camelcase' -- Формат тегов в CamelCase
                vim.g.go_template_autocreate = 1         -- Автосоздание шаблонов
                vim.g.go_template_use_pkg = 1            -- Использовать имя пакета в шаблонах
                vim.g.go_metalinter_enabled = {          -- Включенные линтеры
                    'vet',
                    'golint',
                    'errcheck',
                }
                vim.g.go_metalinter_autosave = 1    -- Запуск линтеров при сохранении
                vim.g.go_metalinter_deadline = '5s' -- Таймаут для линтеров

                -- Настройки окон
                vim.g.go_term_enabled = 1    -- Использовать встроенный терминал
                vim.g.go_term_mode = "split" -- Режим разделения окна для терминала
                vim.g.go_term_height = 10    -- Высота окна терминала
                vim.g.go_term_reuse = 1      -- Переиспользовать окно терминала

                -- Автокоманды
                vim.api.nvim_create_autocmd("FileType", {
                    pattern = "go",
                    callback = function()
                        -- Установка локальных опций для Go файлов
                        vim.opt_local.expandtab = false -- Использовать табы вместо пробелов
                        vim.opt_local.tabstop = 4       -- Ширина таба
                        vim.opt_local.shiftwidth = 4    -- Ширина отступа
                    end,
                })
            end,
        },

        -- Плагин для расширенного автодополнения
    }
}
