return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      vim.keymap.set(
        "n",
        "<leader>e",
        ":Neotree filesystem toggle left<CR>",
        { noremap = true, silent = true, desc = "NeoTree Explorer left" }
      )
      vim.keymap.set(
        "n",
        "<leader>xx",
        ":Neotree filesystem close<CR>",
        { noremap = true, silent = true, desc = "NeoTree close" }
      )
    end,
  },
}
