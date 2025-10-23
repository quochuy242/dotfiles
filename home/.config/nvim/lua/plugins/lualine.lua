return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function()
    local trouble = require("trouble")
    local symbols = trouble.statusline({
      mode = "lsp_document_symbols",
      groups = {},
      title = false,
      filter = { range = true },
      format = "{kind_icon}{symbol.name:Normal}",
      hl_group = "lualine_c_normal",
    })

    require("lualine").setup({
      options = {
        theme = "tokyonight",
        section_separators = { left = "", right = "" },
        component_separators = { left = "|", right = "|" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          { symbols.get, cond = symbols.has },
        },
        lualine_x = {
          { "filetype", icon_only = true },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = { "fzf", "lazy", "mason", "neo-tree", "trouble" },
    })
  end,
}
