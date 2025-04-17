return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-ui-select.nvim" },
  },
  cmd = "Telescope",
  config = function()
    local telescope = require("telescope")

    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
    telescope.setup({
      defaults = {
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = { prompt_position = "top" },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        },
        ui_select = {
          require("telescope.themes").get_dropdown({}),
        },
      },
    })
  end,
  ft = 'mason',
  keys = {
    { "<leader>ff", "<cmd> Telescope find_files <CR>" },
    { "<leader>fo", "<cmd> Telescope oldfiles <CR>" },
    { "<leader>fg", "<cmd> Telescope live_grep <CR>" },
    { "<leader>gt", "<cmd> Telescope git_status <CR>" },
    { "<C-f>", function()
      require("telescope.builtin").live_grep()
    end }
  }
}
