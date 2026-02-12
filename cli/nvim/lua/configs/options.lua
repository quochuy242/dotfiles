local o = vim.o
local opt = vim.opt
local wo = vim.wo

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
