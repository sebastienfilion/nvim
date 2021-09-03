local show_terminal = function(b, x)
  vim.cmd('botright vsplit new')
  vim.cmd('vertical resize ' .. x)
  vim.cmd('buffer ' .. b)
  vim.cmd('startinsert!') 
end

local create_terminal = function(x)
  vim.cmd('botright vsplit new')
  vim.cmd('vertical resize ' .. x)
  vim.fn.termopen(vim.env.SHELL, { detach = 0 }) 
  local b = vim.fn.bufnr('')
  vim.cmd('set nonumber')
  vim.cmd('set norelativenumber')
  vim.cmd('set signcolumn=no')
  vim.cmd('startinsert!')
  return b
end


local hide_terminal = function()
  vim.cmd('hide')
end

local w, b = nil, nil

function _G.toggle_terminal()
  if w ~= nil and b ~= nil and vim.api.nvim_win_is_valid(w) and vim.api.nvim_buf_is_loaded(b) then
    vim.api.nvim_set_current_win(w)
    vim.cmd('startinsert!')
  elseif v ~= nil and vim.api.nvim_buf_is_loaded(b) then 
    show_terminal(b, 80)
    w = vim.api.nvim_get_current_win()
  else
    b = create_terminal(80)
    w = vim.api.nvim_get_current_win()
  end
end

function _G.force_hide_terminal()
  if w ~= nil and vim.api.nvim_win_is_valid(w) then
    vim.api.nvim_win_hide(w)
  end
end

return function()
  vim.api.nvim_set_keymap('n', '<F12>', [[<cmd>lua _G.toggle_terminal()<CR>]], { noremap = true })
  vim.api.nvim_set_keymap('n', '<F12><F12>', [[<cmd>lua _G.force_hide_terminal()<CR>]], { noremap = true })
  vim.api.nvim_set_keymap('t', '<esc><esc>', '<C-\\><C-n>', { noremap = true })
end
