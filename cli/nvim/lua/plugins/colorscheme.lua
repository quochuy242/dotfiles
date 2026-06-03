return {
  {
    'sainnhe/gruvbox-material',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_foreground = 'material'
      vim.g.gruvbox_material_transparent_background = true
      vim.g.gruvbox_material_enable_italic = 0
      vim.g.gruvbox_material_better_performance = 1
    end,
  },
}
