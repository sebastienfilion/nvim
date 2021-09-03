local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd('packadd packer.nvim')
end

local plugins = {
  { name = 'famiu/feline.nvim', config = true },
  { name = 'cocopon/iceberg.vim', config = true },
  { name = 'mfussenegger/nvim-dap', config = false },
  { name = 'neovim/nvim-lspconfig', config = false },
  { name = 'kabouzeid/nvim-lspinstall', config = false },
}

-- Generate short name for plugin to use as filename
local function pluginIdentifierToFilename (identifier)
  return string.match(identifier, '/([^%.]*)%.?.*$')
end

-- Build packer specs
local specs = {}
for i, plugin in ipairs(plugins) do
  specs[i] = { plugin.name }

  if plugin.config then
    local filename = pluginIdentifierToFilename(plugin.name)
    specs[i].config = require('plugins.configuration.' .. filename)
  end
end

-- Launch packer and call on all specs
require('packer').startup(
  function(use)
    for _, spec in ipairs(specs) do
      use(spec)
    end
  end
)

local local_plugins = vim.fn.map(
    vim.fn.glob(
      vim.fn.fnameescape(
        vim.fn.stdpath('config') .. '/lua/plugins'
      ) .. '/{,.}*/',
      1,
      1
    ),
    'fnamemodify(v:val, ":h:t")'
  )

for k, v in pairs(local_plugins) do
  if (v ~= 'configuration') then
    local p = require('plugins.' .. v)
    if p then p() end
    table.insert(specs, { v })
  end
end
-- Provide specs for use in other files
return specs

