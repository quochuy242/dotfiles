-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Split window
map("n", "ss", ":split<Return>", { desc = "Split window horizontally" })
map("n", "sv", ":vsplit<Return>", { desc = "Split window vertically" })

-- Move to window
map("n", "<Up>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<Down>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<Left>", "<C-w>h", { desc = "Go to left window" })
map("n", "<Right>", "<C-w>l", { desc = "Go to right window" })
map("n", "<C-h", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-j", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-l", "<C-w>l", { desc = "Go to right window" })

-- Resize window
map("n", "<C-Up>", "<cmd>resize -2<CR>")
map("n", "<C-Down>", "<cmd>resize +2<CR>")
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- Move line
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- Copy and paste the current line below
map("n", "yp", "yyp", { noremap = true, silent = true })

-- save and quit map
map("n", "<C-q>", ":q<CR>", { desc = "Quit" }) -- quit
map("n", "<leader>q", ":qa<CR>", { desc = "Quit all" }) -- close all buffers
map({ "i", "n", "x", "s" }, "<C-s>", "<cmd>w<cr>", { desc = "Save" }) -- save

-- Lazy
map("n", "<leader>l", ":Lazy<CR>", { desc = "Lazy" })
