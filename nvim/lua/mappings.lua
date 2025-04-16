local map = vim.keymap.set

-- general mappings
map("i", "jk", "<ESC>")
map("n", "<C-c>", "<cmd> %y+ <CR>")           -- copy whole filecontent
map({ "n", "v" }, "<leader>q", "<cmd> qa <CR>") -- quit nvim

-- nvimtree
map("n", "<leader>e", "<cmd> Neotree filesystem reveal right <CR>")

-- telescope
map("n", "<leader>ff", "<cmd> Telescope find_files <CR>")
map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>")
map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>")
map("n", "<leader>gt", "<cmd> Telescope git_status <CR>")

-- bufferline, cycle buffers
map("n", "<Tab>", "<cmd> BufferLineCycleNext <CR>")
map("n", "<S-Tab>", "<cmd> BufferLineCyclePrev <CR>")
map("n", "<C-q>", "<cmd> bd <CR>")

-- comment.nvim
map("n", "<leader>/", "gcc", { remap = true })
map("v", "<leader>/", "gc", { remap = true })

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
