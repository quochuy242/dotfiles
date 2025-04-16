return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "nvim-neo-tree/neo-tree.nvim" },
  config = function()
    require("bufferline").setup({
      options = {
        offsets = {
          {
            filetype = "Neotree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "center",
          },
        },
      },
    })
    local map = vim.keymap.set
    map("n", "<Tab>", "<cmd> BufferLineCycleNext <CR>")
    map("n", "<S-Tab>", "<cmd> BufferLineCyclePrev <CR>")
    map("n", "<C-q>", "<cmd> bd <CR>")
  end
}
