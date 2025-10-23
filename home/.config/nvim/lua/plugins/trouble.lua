return {

  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    -- Trouble is a pretty list for showing diagnostics, references, etc.
    -- It works as a better quickfix/location list replacement.
    -- Useful for navigating errors, warnings, TODOs, or LSP references.
    modes = {
      preview_float = {
        mode = "diagnostics",
        preview = {
          type = "float",
          relative = "editor",
          border = "rounded",
          title = "Preview",
          title_pos = "center",
          position = { 0, -2 },
          size = { width = 0.3, height = 0.3 },
          zindex = 200,
        },
      },
    },
  },
  keys = {
    -- Show diagnostics only for the current buffer
    { "<leader>db", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",         desc = "[D]iagnostics for [B]uffer" },

    -- Show LSP references under the cursor
    { "<leader>dr", "<cmd>ces toggle<cr>",                   desc = "[D]iagnostics [R]eferences" },

    -- Show definitions, implementations, type definitions
    { "<leader>dd", "<cmd>Trouble lsp_definitions toggle<cr>",                  desc = "[D]iagnostics [D]efinitions" },
    { "<leader>di", "<cmd>Trouble lsp_implementations toggle<cr>",              desc = "[D]iagnostics [I]mplementations" },
    { "<leader>dt", "<cmd>Trouble lsp_type_definitions toggle<cr>",             desc = "[D]iagnostics [T]ype Definitions" },

    -- Show symbols from workspace or document
    { "<leader>ds", "<cmd>Trouble lsp_document_symbols toggle focus=false<cr>", desc = "[D]ocument [S]ymbols" },
    {
      "<leader>ws",
      "<cmd>Trouble lsp_workspace_symbols toggle focus=false<cr>",
      desc = "[W]orkspace [S]ymbols",
    },

    -- Show TODOs, FIX, HACK, WARN, etc. if you use todo-comments.nvim
    { "<leader>dtd", "<cmd>Trouble todo toggle<cr>", desc = "[T]ODOs" },
  },

  config = function()
    local config = require("fzf-lua.config")
    local actions = require("trouble.sources.fzf").actions

    config.defaults.actions.files["ctrl-t"] = actions.open
  end,
}
