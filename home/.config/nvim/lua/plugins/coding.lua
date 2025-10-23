return {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  {
    "chomosuke/typst-preview.nvim",
    lazy = false, -- or ft = 'typst'
    version = "1.*",
    config = function()
      require("typst-preview").setup({})
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "tinymist",
        "lua_ls",
        "basedpyright",
        "omnisharp",
        "rust_analyzer",
        "gopls",
        "bashls",
        "sqlls",
      },
    },
  },

  -- [[ LSP Config ]]
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Optional: nvim-cmp capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if cmp_ok then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end
      local on_attach = function(client, bufnr)
        local map = vim.keymap.set
        local opts = { buffer = bufnr, remap = false }

        map("n", "gd", vim.lsp.buf.definition, { desc = "[G]o to [D]efinition", buffer = bufnr })
        map("n", "gr", vim.lsp.buf.references, { desc = "[G]o to [R]eferences", buffer = bufnr })
        map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation", buffer = bufnr })
        map("n", "<leader>r", vim.lsp.buf.rename, { desc = "[R]ename symbol", buffer = bufnr })
        map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction", buffer = bufnr })
      end

      -- ======================
      -- Python
      -- ======================
      lspconfig["basedpyright"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        flags = { debounce_text_changes = 150 },
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

      -- ======================
      -- Lua
      -- ======================
      lspconfig["lua_ls"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })

      -- ======================
      -- C#
      -- ======================
      lspconfig["omnisharp"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
      })

      -- ======================
      -- Go
      -- ======================
      lspconfig["gopls"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true } },
      })

      -- ======================
      -- Rust
      -- ======================
      lspconfig["rust_analyzer"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = { command = "clippy" },
          },
        },
      })

      -- ======================
      -- SQL
      -- ======================
      lspconfig["sqlls"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- ======================
      -- Bash
      -- ======================
      lspconfig["bashls"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "sh", "bash", "zsh" },
      })

      -- ======================
      -- Typst
      -- ======================
      lspconfig["tinymist"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          formatterMode = "typstyle",
          exportPdf = "onType",
          semanticTokens = "disable",
        },
      })
    end,
  },

  -- [[ Lazy dev tools ]]
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    "folke/lazydev.nvim",
    ft = "lua",
    pts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

}
