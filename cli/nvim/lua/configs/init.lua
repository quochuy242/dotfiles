require 'configs.autocmds'
require 'configs.options'
require 'configs.mappings'
-- Check if fcitx5-remote exists before loading fcitx-helper
if vim.fn.executable 'fcitx5-remote' == 1 then
  require 'configs.fcitx-helper'
end
