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
vim.keymap.set('n', '<leader>gid', ':vert rightbelow Gitsigns diffthis<CR>', { noremap = true, silent = true })

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





-- buffer navigation
vim.keymap.set('n', '<A-,>', '<Cmd>BufferPrevious<CR>', { desc = "Previous buffer" })
vim.keymap.set('n', '<A-.>', '<Cmd>BufferNext<CR>', { desc = "Next buffer" })
vim.keymap.set('n', '<A-c>', '<Cmd>BufferClose<CR>', { desc = "Close buffer" })



-- Common LSP keymaps
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Show hover information" })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { desc = "Show signature help" })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "Show references" })


-- -- lspsaga
-- -- Переход к определению/реализации с предпросмотром
-- vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>")
-- vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>")
-- -- Показывает кто вызывает/вызывается текущей функцией
-- vim.keymap.set("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
-- vim.keymap.set("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>")


-- --snipet
-- local ls = require("luasnip")
-- ls.filetype_extend("javascript", { "jsdoc" })

--- TODO: What is expand?
-- vim.keymap.set({ "i" }, "<C-s>e", function() ls.expand() end, { silent = true })
--
-- vim.keymap.set({ "i", "s" }, "<C-s>;", function() ls.jump(1) end, { silent = true })
-- vim.keymap.set({ "i", "s" }, "<C-s>,", function() ls.jump(-1) end, { silent = true })
--
-- vim.keymap.set({ "i", "s" }, "<C-E>", function()
--     if ls.choice_active() then
--         ls.change_choice(1)
--     end
-- end, { silent = true })
