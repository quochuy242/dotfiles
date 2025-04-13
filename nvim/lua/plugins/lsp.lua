return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
    opts = {
      ensure_installed = {
        "gopls",
        "pyright",
        "rust-analyzer",
        "lua-language-server",
        "r-languageserver",
        "dockerfile-language-server",
        "terraform-ls",
        "gofumpt",
        "goimports",
        "gopls",
        "hadolint",
        "json-lsp",
        "lua-language-server",
        "luacheck",
        "markdownlint-cli2",
        "pyright",
        "ruff",
        "rust-analyzer",
        "shfmt",
        "stylua",
        "terraform-ls",
        "tflint",
        "bash-debug-adapter",
        "beautysh",
        "shellcheck",
        "bash-language-server",
        "sqlfluff",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Lua
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      -- Python
      lspconfig.pyright.setup({
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })

      -- Golang
      lspconfig.gopls.setup({
        cmd = { "gopls", "serve" },
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
      })

      -- Rust (Cargo.toml)
      lspconfig.rust_analyzer.setup({
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              loadOutDirsFromCheck = true,
            },
            procMacro = {
              enable = true,
            },
          },
        },
      })
    end,
  }

}
