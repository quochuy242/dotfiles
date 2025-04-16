return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  opts = {
    defaults = {
      sorting_strategy = "ascending",
      layout_config = {
        horizontal = { prompt_position = "top" },
      },
    }
  },
  keys = {
    { "<leader>ff", "<cmd> Telescope find_files <CR>" },
    { "<leader>fo", "<cmd> Telescope oldfiles <CR>" },
    { "<leader>fg", "<cmd> Telescope live_grep <CR>" },
    { "<leader>gt", "<cmd> Telescope git_status <CR>" },
  }
}
