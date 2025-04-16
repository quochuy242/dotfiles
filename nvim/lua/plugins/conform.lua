return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo " },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettier" },
      python = { "ruff" },
      rust = { "rustfmt" },
      go = { "gofmt" },
      markdown = { "prettier" },
    }
  },
}
