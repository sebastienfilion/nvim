return function()
  vim.api.nvim_set_keymap('n', '<esc><esc>', ':silent! nohls<CR>', {})

  vim.g['netrw_banner'] = 0
  vim.g['netrw_liststyle'] = 3
  vim.g['netrw_browse_split'] = 4
  vim.g['netrw_altv'] = 1
  vim.g['netrw_winsize'] = 15

  vim.api.nvim_set_keymap(
    'n',
    '<leader>n',
    [[:Vexplore<CR>]],
    { noremap = true }
  )

  vim.api.nvim_set_keymap('n', '<M-Right>', '<C-w>l', {})
  vim.api.nvim_set_keymap('n', '<M-Up>', '<C-w>k', {})
  vim.api.nvim_set_keymap('n', '<M-Down>', '<C-w>j', {})
  vim.api.nvim_set_keymap('n', '<M-Left>', '<C-w>h', {})
end
