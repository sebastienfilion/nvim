local options = {
  autoread = true,
  background = 'dark',
  backup = false,
  cc = '80',
  cmdheight = 1,
  cursorline = true,
  expandtab = true,
  hidden = true,
  ignorecase = true,
  number = true,
  scrolloff = 15,
  shiftwidth = 2,
  showmode = false,
  showmatch = true,
  smartcase = true,
  smartindent = true,
  softtabstop = 2,
  tabstop = 2,
  termguicolors = true,
  timeoutlen = 600,
  ttimeoutlen = 80,
  undofile = true,
  updatetime = 300,
  wrap = true,
  writebackup = false,
  wildmode = 'longest,list'
}

function _G.setOptions()
  for k, v in pairs(options) do
    vim.opt[k] = v
  end

  vim.cmd('filetype on')
  vim.cmd('syntax on')
end
_G.setOptions()

