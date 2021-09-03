local plugins = require('plugins')
require('core.options')
require('core.theme')

local count = function(T)
  local i = 0
  for _ in pairs(T) do i = i + 1 end
  return i
end

function _G.reload ()
  vim.cmd("silent write!")
  for k, v in pairs(plugins) do
    package.loaded[v[1]] = nil
  end
  vim.cmd('silent source ' .. vim.fn.stdpath('config') .. '/init.lua') 
  print("Force Reloading packages: " .. count(plugins), vim.fn.stdpath('config') .. '/init.lua')
end

vim.api.nvim_set_keymap('n', '<C-S>', [[<cmd>lua _G.reload()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<C-Q>', [[<cmd>split<CR>]], { noremap = true })


