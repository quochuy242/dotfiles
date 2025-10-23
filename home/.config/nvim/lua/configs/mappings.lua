local map = vim.keymap.set
local map_opt = { noremap = true, silent = true }

-- [[ Global keymaps ]]
vim.g.mapleader = " "
map({ "i", "v" }, "jk", "<Esc>") -- Quick exit from insert and visual mode
map({ "i", "v" }, "kj", "<Esc>") -- Quick exit from insert and visual mode
map({ "n", "v" }, "<space>", "<Nop>", { silent = true }) -- Disable the space key
map("n", "<C-c>", "<cmd> %y+ <CR>") -- copy whole filecontent
map({ "n", "v" }, "<leader>q", "<cmd> q <CR>", { desc = "Close the current window" }) -- close the current window
map({ "n", "v" }, "<leader>Q", "<cmd> qa <CR>", { desc = "Quit neovim" })
map("n", "<leader>a", "ggVG") -- select all
map("n", "<leader>lw", "<cmd>set wrap!<CR>", { desc = "[L]ine [W]rap", silent = true }) -- toggle line wrap

-- Fuzzy search in current buffer using fzf-lua
map("n", "<leader>/", function()
	require("fzf-lua").lgrep_curbuf({ winopts = { preview = { hidden = true }, height = 0.5, width = 0.5 } })
end, { desc = "[/] Fuzzily search in current buffer (fzf-lua)" })

-- auto format while saving
local function format_on_save()
	-- 1. Formatting
	require("conform").format({ async = true })
	-- 2. Save
	vim.cmd("w")
end

map("n", "<C-S>", format_on_save, { desc = "Format, save and optionally apply chezmoi" })
map("i", "<C-S>", function()
	vim.cmd("stopinsert") -- Exit insert mode
	format_on_save()
end, { desc = "Format, save and optionally apply chezmoi" })

-- Delete single character without copying into register
map("n", "x", '"_x', map_opt)

-- Replace by pasting without copy
map("x", "p", [["_dP]])

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Move focus between splits
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Other plugins' keymaps
map("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "[L]azy" })
map("n", "<leader>lu", "<cmd>Lazy update<CR>", { desc = "[L]azy [U]pdate" })
map("n", "<leader>m", "<cmd>Mason<CR>", { desc = "[M]ason" })
map("n", "<leader>mu", "<cmd>MasonUpdate<CR>", { desc = "[M]ason [U]pdate" })
