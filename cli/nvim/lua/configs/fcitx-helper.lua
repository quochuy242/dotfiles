-- Set the language based on the vim mode

local is_linux = vim.loop.os_uname().sysname == 'Linux'

-- The helper may not work on the other OS except Linux
if is_linux then
  local default_layout = 'keyboard-us'
  local last_layout = default_layout

  -- [[ Functions ]]
  local function get_current_layout()
    local f = io.popen 'fcitx5-remote -n'
    local layout = nil
    if f ~= nil then
      layout = f:read('*all'):gsub('%s+', '')
      f:close()
    end
    return layout
  end

  local function set_layout(layout)
    os.execute('fcitx5-remote -s ' .. layout)
  end

  -- [[ Autocmd ]]
  -- If exit insert mode, set the en layout
  vim.api.nvim_create_autocmd('InsertLeave', {
    callback = function()
      local current = get_current_layout()
      last_layout = current
      set_layout(default_layout)
    end,
  })

  -- If enter insert mode, set the last layout
  vim.api.nvim_create_autocmd('InsertEnter', {
    callback = function()
      set_layout(last_layout)
    end,
  })

  -- If enter command mode, set the default layout
  vim.api.nvim_create_autocmd('CmdlineEnter', {
    callback = function()
      set_layout(default_layout)
    end,
  })

  -- When back to nvim, restore the last layout
  vim.api.nvim_create_autocmd('FocusGained', {
    callback = function()
      if vim.fn.mode() == 'i' then
        set_layout(last_layout)
      else
        set_layout(default_layout)
      end
    end,
  })
end
