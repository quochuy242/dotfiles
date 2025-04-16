return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "williamboman/mason.nvim",
      build = ":MasonUpdate",
      cmd = { "Mason", "MasonInstall" },
      opts = {
        ensure_installed = {
          -- LSP servers
          "pyright",
          "lua-language-server",
          "rust_analyzer",
          "gopls",
          -- Formatters
          "stylua",
          "prettier",
          "ruff",
          "rustfmt",
          "gofmt"
        },
      },
    },
    { "williamboman/mason-lspconfig.nvim" },
  },
  config = function()
    -- Global on_attach function
    local on_attach = function(_, bufnr)
      local opts = { buffer = bufnr }
      local map = vim.keymap.set

      map("n", "gD", vim.lsp.buf.declaration, opts)
      map("n", "gd", vim.lsp.buf.definition, opts)
      map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
      map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
      map("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      map("n", "<space>D", vim.lsp.buf.type_definition, opts)
      map("n", "<space>rn", vim.lsp.buf.rename, opts)
    end

    -- Define LSP capabilities for completion
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem = {
      documentationFormat = { "markdown", "plaintext" },
      snippetSupport = true,
      preselectSupport = true,
      insertReplaceSupport = true,
      labelDetailsSupport = true,
      deprecatedSupport = true,
      commitCharactersSupport = true,
      tagSupport = { valueSet = { 1 } },
      resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      },
    }

    -- Setup LSP servers with capabilities
    local servers = {
      pyright = {},
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            }
          }
        }
      },
      rust_analyzer = {},
      gopls = {},
    }

    local lspconfig = require("lspconfig")
    for server, config in pairs(servers) do
      lspconfig[server].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = config,
      }
    end
  end,
}
