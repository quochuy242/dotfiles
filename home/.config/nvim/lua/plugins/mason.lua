return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      -- list of servers for mason to install
      ensure_installed = {
        "tinymist",
        "lua_ls",
        "pyright",
        "omnisharp",
        "rust_analyzer",
        "gopls",
        "bashls",
        "sqlls",
      },
    },
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {
          ui = {
            icons = {
              package_installed = "",
              package_pending = "",
              package_uninstalled = "",
            },
          },
        },
      },
      "neovim/nvim-lspconfig",
    },
  },
}
