-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- No loading of providers for not using languages
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_java_provider = 0


-- Global options
local opt = vim.opt
opt.encoding = "utf-8"                                  -- The encoding displayed
opt.fileencoding = "utf-8"                              -- The encoding written to file
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with sys clipboard
opt.mouse = "a"                                         -- Enable mouse mode
opt.wrap = false                                        -- Disable line wrap
opt.shiftwidth = 2                                      -- The number of spaces inserted for each indentation
opt.tabstop = 2                                         -- Insert 2 spaces for a tab
opt.relativenumber = true                               -- Relative line numbers
opt.termguicolors = true                                -- True color support
