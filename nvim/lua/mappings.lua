local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- General mappings
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
map("i", "jk", "<ESC>")
map("n", "<C-c>", "<cmd> %y+ <CR>")             -- copy whole filecontent
map({ "n", "v" }, "<leader>q", "<cmd> qa <CR>") -- quit nvim

-- Disable the spacebar key's default behavior in Normal and Visual modes
map({ 'n', 'v' }, '<space>', '<Nop>', { silent = true })

-- Toggle line wrapping
map('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- auto format while saving
map("n", "<C-s>", function()
  require("conform").format({ async = true })
  vim.cmd("w")
end, { desc = "Format and save" })
map("i", "<C-s>", function()
  vim.cmd("stopinsert") -- Exit insert mode
  require("conform").format({ async = true })
  vim.cmd("w")
end, { desc = "Format and Save in Insert Mode" })

-- Delete single character without copying into register
map('n', 'x', '"_x', opts)

-- Replace by pasting without copy
map("x", "p", [["_dP]])

-- Stay in indent mode
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- Window management
map('n', '<leader>v', '<C-w>v', opts)      -- split window vertically
map('n', '<leader>h', '<C-w>s', opts)      -- split window horizontally
map('n', '<leader>se', '<C-w>=', opts)     -- make split windows equal width & height
map('n', '<leader>xs', ':close<CR>', opts) -- close current split window

-- Navigate between splits
map('n', '<C-k>', ':wincmd k<CR>', opts)
map('n', '<C-j>', ':wincmd j<CR>', opts)
map('n', '<C-h>', ':wincmd h<CR>', opts)
map('n', '<C-l>', ':wincmd l<CR>', opts)

-- Move text up and down
map('v', '<A-j>', ':m .+1<CR>==', opts)
map('v', '<A-k>', ':m .-2<CR>==', opts)
