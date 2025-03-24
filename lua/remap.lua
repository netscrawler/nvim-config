vim.g.mapleader = " "


vim.api.nvim_set_keymap('n', '<leader>pp', ':ProjectMgr<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>pc', '<cmd>Telescope projectmgr create_project<cr>',
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>pd', '<cmd>Telescope projectmgr delete_project<cr>',
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>pr', '<cmd>Telescope projectmgr rename_project<cr>',
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-Q>', '<C-V>', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-Q>', '<C-V>', { noremap = true })


vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


-- lspsaga
-- Переход к определению/реализации с предпросмотром
vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>")
vim.keymap.set("n", "gi", "<cmd>Lspsaga goto_implementation<CR>")
vim.keymap.set("n", "gr", "<cmd>Lspsaga finder<CR>") -- Находит все ссылки
-- Навигация по диагностическим сообщениям
vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
-- Показать структуру текущего файла
vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>") -- Переименование символа с предпросмотром изменений
vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>")
-- Переименование с поддержкой нескольких файлов
vim.keymap.set("n", "<leader>rN", "<cmd>Lspsaga rename ++project<CR>")
-- Показывает кто вызывает/вызывается текущей функцией
vim.keymap.set("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
vim.keymap.set("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>")








vim.keymap.set("n", "<leader>tf", "<cmd>TodoTelescope<CR>", { desc = "Найти TODO заметки с помощью Telescope" })

vim.keymap.set('n', '<A-h>', '<C-w>h', { noremap = true, silent = true }) -- Влево
vim.keymap.set('n', '<A-j>', '<C-w>j', { noremap = true, silent = true }) -- Вниз
vim.keymap.set('n', '<A-k>', '<C-w>k', { noremap = true, silent = true }) -- Вверх
vim.keymap.set('n', '<A-l>', '<C-w>l', { noremap = true, silent = true }) -- Вправо

vim.api.nvim_set_keymap('n', '<leader>bn', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bp', ':bprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bd', ':bd<CR>', { noremap = true, silent = true })



vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'DiffAdd' })
vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'DiffChange' })
vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'DiffDelete' })

-- Пример горячих клавиш для управления Git
vim.keymap.set('n', '<leader>gis', ':Gitsigns stage_hunk<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gir', ':Gitsigns reset_hunk<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gip', ':Gitsigns preview_hunk<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gib', ':Gitsigns blame_line<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gid', ':Gitsigns diffthis<CR>', { noremap = true, silent = true })

-- Пример горячих клавиш для помощи по сигнатуре
vim.api.nvim_set_keymap('n', '<leader>hs', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })


vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])



vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

-- This is going to get me cancelled
--vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })


vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)



--snipet
local ls = require("luasnip")
ls.filetype_extend("javascript", { "jsdoc" })

--- TODO: What is expand?
vim.keymap.set({ "i" }, "<C-s>e", function() ls.expand() end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-s>;", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-s>,", function() ls.jump(-1) end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { silent = true })
