local api = vim.api

-- Create an augroup for organizing autocommands
local augroup = api.nvim_create_augroup("UserAutocmds", { clear = true })

-- 1. Highlight text on yank
api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
  end,
  desc = "Highlight text when yanked",
})

-- 2. Remove trailing whitespace on save
api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = "*",
  command = [[%s/\s\+$//e]],
  desc = "Remove trailing whitespace on save",
})

-- 3. Return to last edit position when opening a file
api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function()
    local mark = vim.fn.line("'\"")
    if mark > 0 and mark <= vim.fn.line("$") then
      vim.cmd("normal! g`\"")
    end
  end,
  desc = "Return to last edit position when opening a file",
})

-- 4. Start terminal in insert mode
api.nvim_create_autocmd("TermOpen", {
  group = augroup,
  command = "startinsert",
  desc = "Start terminal in insert mode",
})

-- 5. Open help files in vertical splits
api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "help",
  command = "wincmd L",
  desc = "Open help files in vertical splits",
})

-- 6. Enable spell checking for text-related filetypes
api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.spell = true
  end,
  desc = "Enable spell checking for certain filetypes",
})

-- 7. Automatically resize splits when the window is resized
api.nvim_create_autocmd("VimResized", {
  group = augroup,
  command = "tabdo wincmd =",
  desc = "Automatically resize splits when the window is resized",
})
