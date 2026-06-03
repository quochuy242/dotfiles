return {
  {
    'williamboman/mason-lspconfig.nvim',
    init = function()
      local ok, registry = pcall(require, 'mason-registry')
      if not ok or registry.__codex_refresh_patched then
        return
      end

      local original_refresh = registry.refresh
      registry.refresh = function(cb)
        if cb == nil then
          return original_refresh()
        end

        return original_refresh(function(success, updated_registries)
          cb(success, updated_registries or {})
        end)
      end

      registry.__codex_refresh_patched = true
    end,
    opts = {
      -- list of servers for mason to install
      ensure_installed = {
        'tinymist',
        'lua_ls',
        'pyright',
        'omnisharp',
        'rust_analyzer',
        'gopls',
        'bashls',
        'sqlls',
      },
    },
    dependencies = {
      {
        'williamboman/mason.nvim',
        init = function()
          local ok, package = pcall(require, 'mason-core.package')
          if not ok or package.is_installing ~= nil then
            return
          end

          -- Compatibility shim for older mason.nvim builds that do not expose
          -- Package:is_installing(), but are used by newer mason-lspconfig.nvim.
          function package:is_installing()
            local handle = self:get_handle()
            if handle:is_present() then
              return not handle:get():is_closed()
            end
            return false
          end
        end,
        opts = {
          ui = {
            icons = {
              package_installed = '',
              package_pending = '',
              package_uninstalled = '',
            },
          },
        },
      },
      'neovim/nvim-lspconfig',
    },
  },
}
