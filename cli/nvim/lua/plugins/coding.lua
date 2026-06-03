return {
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },
  {
    'chomosuke/typst-preview.nvim',
    lazy = false, -- or ft = 'typst'
    version = '1.*',
    config = function()
      require('typst-preview').setup {}
    end,
  },
  -- [[ LSP Config ]]
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require 'lspconfig'

      -- Optional: nvim-cmp capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
      if cmp_ok then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      -- Python
      lspconfig['pyright'].setup {
        capabilities = capabilities,
        flags = { debounce_text_changes = 150 },
        settings = {
          python = {
            analysis = {
              typeCheckingMode = 'basic',
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      }

      -- Lua
      lspconfig['lua_ls'].setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = { library = vim.api.nvim_get_runtime_file('', true), checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      }

      -- C#
      lspconfig['omnisharp'].setup {
        capabilities = capabilities,
        cmd = { 'omnisharp', '--languageserver', '--hostPID', tostring(vim.fn.getpid()) },
      }

      -- Go
      lspconfig['gopls'].setup {
        capabilities = capabilities,
        settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true } },
      }

      -- Rust
      lspconfig['rust_analyzer'].setup {
        capabilities = capabilities,
        settings = {
          ['rust-analyzer'] = {
            cargo = { allFeatures = true },
            checkOnSave = { command = 'clippy' },
          },
        },
      }

      -- SQL
      lspconfig['sqlls'].setup {
        capabilities = capabilities,
      }

      -- Bash
      lspconfig['bashls'].setup {
        capabilities = capabilities,
        filetypes = { 'sh', 'bash', 'zsh' },
      }

      -- Typst
      lspconfig['tinymist'].setup {
        capabilities = capabilities,
        settings = {
          formatterMode = 'typstyle',
          exportPdf = 'onType',
          semanticTokens = 'disable',
        },
      }
    end,
  },
  -- [[ Lazy dev tools ]]
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
}
