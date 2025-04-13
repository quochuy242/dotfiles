return {{
  "goolord/alpha-nvim",
  enabled = false
}, {
  "folke/snacks.nvim",
  event = "VimEnter",
  ---@type snacks.Config
  opts = {{
    dashboard = {
      enabled = true,
      sections = {{
        section = "terminal",
        cmd = "chafa $HOME/.config/assets/65.png --format symbols --symbols vhalf --size 60x17 --stretch; sleep .1",
        height = 17,
        padding = 1
      }, {
        pane = 2,
        {
          section = "keys",
          gap = 1,
          padding = 1
        },
        {
          section = "startup"
        }
      }}
    }
  }}
}}
