return {
  {
    "Exafunction/windsurf.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({})
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",   -- Completion from current buffer
      "hrsh7th/cmp-path",     -- Completion from filesystem paths
      "hrsh7th/cmp-nvim-lsp", -- Completion from LSP
      "hrsh7th/cmp-nvim-lua", -- Completion from Neovim Lua API
      "hrsh7th/cmp-cmdline",  -- Completion for command line
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        -- Keymaps for completion
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),        -- Next suggestion
          ["<C-p>"] = cmp.mapping.select_prev_item(),        -- Previous suggestion
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
        }),

        -- Sources for completion
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- LSP suggestions
          { name = "buffer" },   -- Words from buffer
          { name = "path" },     -- File paths
          { name = "nvim_lua" }, -- Lua API for Neovim
          { name = "codeium" },  -- AI completion
        }),

        -- Window appearance
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        -- Experimental ghost text (inline suggestion like VSCode)
        experimental = {
          ghost_text = true,
        },

        -- Formatting of completion items
        formatting = {
          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "",
              buffer = "",
              path = "󰉋",
              nvim_lua = "󰢱",
              codeium = "󱡄",
            })[entry.source.name]
            return vim_item
          end,
        },
      })

      -- Completion for search `/` in buffer
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      -- Completion for command line `:`
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "cmdline" },
        }, {
          { name = "path" },
        }),
      })
    end,
  },
}
