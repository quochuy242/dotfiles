return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }
    map("n", "<leader>/", require("Comment.api").toggle.linewise.current, opts)
    map("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)
  end
}
