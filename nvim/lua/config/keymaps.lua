-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local key = vim.keymap

-- Split window
key.set("n", "ss", ":split<Return>", { noremap = true, silent = true })
key.set("n", "sv", ":vsplit<Return>", { noremap = true, silent = true })

-- Move window
key.set("n", "<Up>", "<c-w>k")
key.set("n", "<Down>", "<c-w>j")
key.set("n", "<Left>", "<c-w>h")
key.set("n", "<Right>", "<c-w>l")

-- Copy and paste the current line below
key.set("n", "yp", "yyp", { noremap = true, silent = true })
