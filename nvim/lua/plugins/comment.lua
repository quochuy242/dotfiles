return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local map = vim.keymap.set
    map("n", "<leader>/", "gcc")
    map("v", "<leader>/", "gc")
  end
}
