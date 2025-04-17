return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        no_italic = true,
        term_colors = true,
        transparent_background = true,
        styles = {
          comments = {},
          conditionals = {},
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
        },
        color_overrides = {
          mocha = {
            mantle = "#1e1e1e",
            crust = "#050505",
          },
        },
        integrations = {
          telescope = {
            enabled = true,
            style = "nvchad",
          },
          dropbar = {
            enabled = true,
            color_mode = true,
          },
          gitsigns = {
            enabled = true,
          },
          alpha = true,
          neotree = true,
          indent_blankline = {
            enabled = true,
            scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
            colored_indent_levels = false,
          },
          mason = true,
        }
      }
      vim.cmd.colorscheme "catppuccin"
    end
  }
}
