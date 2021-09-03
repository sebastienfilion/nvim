local lsp = require('lspconfig')
local lspinstall = require('lspinstall')
local servers = { "css", "deno", "html", "json", "lua", "rust", "vim" }

local on_attach = function(_, b)
  vim.api.nvim_buf_set_option(b, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  
  local o = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(b, 'n', 'W', '<cmd>lua vim.lsp.buf.definition()<CR>', o)
  vim.api.nvim_buf_set_keymap(b, 'n', '?', '<cmd>lua vim.lsp.buf.hover()<CR>', o)
  vim.api.nvim_buf_set_keymap(b, 'n', '<C-?>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', o)
  vim.api.nvim_buf_set_keymap(b, 'n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', o)
  vim.api.nvim_buf_set_keymap(b, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', o)

  vim.fn.sign_define("LspDiagnosticsSignError",       { text = " ✕", numhl = "LspDiagnosticsDefaultError" })
  vim.fn.sign_define("LspDiagnosticsSignWarning",     { text = " ▲", numhl = "LspDiagnosticsDefaultWarning" })
  vim.fn.sign_define("LspDiagnosticsSignInformation", { text = " ⁈", numhl = "LspDiagnosticsDefaultInformation" })
  vim.fn.sign_define("LspDiagnosticsSignHint",        { text = " ‼", numhl = "LspDiagnosticsDefaultHint" })
end

local includes = function(xs, y)
  local k = false
  for _, x in pairs(xs) do
    if (x == y) then
      k = true
    end
  end
  return k
end

local function setup_servers()
  lspinstall.setup()
  local installed_servers = lspinstall.installed_servers()
  for _, s in pairs(installed_servers) do
    lsp[s].setup({ on_attach = on_attach })
  end
end

return function()
  setup_servers()

  local installed_servers = lspinstall.installed_servers()
  for _, s in pairs(servers) do
    if (not includes(installed_servers, s)) then
      lspinstall.install_server(s)
    end
  end
  for _, s in pairs(installed_servers) do
    if (not includes(servers, s)) then
      lspinstall.uninstall_server(s)
    end
  end

  lspinstall.post_install_hook = function ()
    setup_servers() -- reload installed servers
    vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
  end
end
