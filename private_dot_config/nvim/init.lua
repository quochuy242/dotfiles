local o = vim.o
local opt = vim.opt
local wo = vim.wo
local map = vim.keymap.set
local map_opt = { noremap = true, silent = true }
local nerd_font = vim.g.have_nerd_font

-- [[ Options ]]
-- General settings
o.clipboard = "unnamedplus" -- Use system clipboard
o.mouse = "a" -- Enable mouse support
o.fileencoding = "utf-8" -- File encoding
o.termguicolors = true -- Enable true color support
o.cmdheight = 1 -- Height of the command line
o.showmode = false -- Hide -- INSERT -- and similar messages
o.showtabline = 0 -- Always hide tabline
o.backup = false -- Disable backup file
o.writebackup = false -- Disable write backup
o.swapfile = false -- Disable swap file
o.undofile = true -- Enable persistent undo
o.timeoutlen = 300 -- Timeout length for mappings (ms)
o.updatetime = 250 -- Faster completion (ms)
o.pumheight = 10 -- Max height of the popup menu
o.conceallevel = 0 -- Make `` visible in markdown files
o.completeopt = "menuone,noselect" -- Completion menu options
o.laststatus = 3 -- Use global statusline
o.breakindent = true -- Enable break indent
o.wildmode = "noselect:lastused,full"
o.wildoptions = "pum"

-- Search settings
o.ignorecase = true -- Ignore case in search
o.smartcase = true -- Override ignorecase if search contains uppercase
o.hlsearch = false -- Disable search highlight

-- Line number settings
wo.number = true -- Show absolute line number
o.relativenumber = true -- Show relative line numbers
o.numberwidth = 4 -- Width of line number column
o.signcolumn = "yes" -- Always show sign column
o.cursorline = true -- Highlight current line

-- Split window behavior
o.splitbelow = true -- Horizontal splits open below
o.splitright = true -- Vertical splits open to the right

-- Indentation settings
o.expandtab = true -- Convert tabs to spaces
o.smartindent = true -- Smart indentation
o.autoindent = true -- Copy indent from current line
o.shiftwidth = 2 -- Number of spaces per indent
o.tabstop = 2 -- Number of spaces a tab counts for
o.softtabstop = 2 -- Number of spaces for <Tab>/<BS>

-- Scrolling behavior
o.scrolloff = 4 -- Keep 4 lines visible above/below cursor
o.sidescrolloff = 8 -- Keep 8 columns visible beside cursor

-- Display settings
opt.fillchars = { eob = " " } -- Hide ~ at end of buffer
o.wrap = false -- Disable line wrapping
o.linebreak = true -- Wrap lines at word boundary
o.whichwrap = "bs<>[]hl" -- Allow certain keys to wrap lines

-- Terminal-builtin
vim.g.terminal_emulator = "/usr/bin/zsh"

-- Highlighting and UI tweaks
vim.api.nvim_set_hl(0, "IndentLine", { link = "Comment" }) -- Style for indent guides
opt.shortmess:append("c") -- Shorten completion messages
opt.iskeyword:append("-") -- Treat hyphenated-words as one word
opt.formatoptions:remove({ "c", "r", "o" }) -- Don’t auto-insert comment leader
opt.runtimepath:remove("/usr/share/vim/vimfiles") -- Remove Vim-only runtime path

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

-- Replace word under cursor or visual selection

-- [[ Autocmds ]]
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 200,
		})
	end,
})

-- Open PDFs from .typ files
vim.api.nvim_create_user_command("OpenPdf", function()
	local filepath = vim.api.nvim_buf_get_name(0)
	if filepath:match("%.typ$") then
		local pdf_path = filepath:gsub("%.typ$", ".pdf")
		vim.system({ "open", pdf_path })
	end
end, {})

-- [[ Load other configuration files ]]
require("fcitx-helper")

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

map("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "[L]azy" })
map("n", "<leader>lu", "<cmd>Lazy update<CR>", { desc = "[L]azy [U]pdate" })
map("n", "<leader>m", "<cmd>Mason<CR>", { desc = "[M]ason" })
map("n", "<leader>mu", "<cmd>MasonUpdate<CR>", { desc = "[M]ason [U]pdate" })

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
require("lazy").setup({
	require("coding"),
	require("mini"),
	require("fzf"),
	require("treesitter"),
	require("ui"),
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
