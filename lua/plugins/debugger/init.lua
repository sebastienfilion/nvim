local dap = require('dap')

return function()
  dap.adapters.chrome = {
      type = "executable",
      command = "node",
      args = {os.getenv("HOME") .. "/.config/nvim/vscode-node-debug2/out/src/nodeDebug.js"}
  }
  
  dap.configurations.javascript = { -- change this to javascript if needed
      {
          type = "chrome",
          request = "attach",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          port = 9229,
          webRoot = "${workspaceFolder}"
      }
  }
  
  dap.configurations.typescript = { -- change to typescript if needed
      {
          type = "chrome",
          request = "attach",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          port = 9229,
          webRoot = "${workspaceFolder}",
      }
  }
  
  vim.fn.sign_define('DapBreakpoint', {text='●', texthl='', linehl='', numhl=''})
  vim.fn.sign_define('DapBreakpointRejected', {text='○', texthl='', linehl='', numhl=''})
  vim.fn.sign_define('DapLogPoint', {text='◆', texthl='', linehl='', numhl=''})
  vim.fn.sign_define('DapStopped', {text='▸', texthl='', linehl='debugPC', numhl=''})

  
  -- nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
  -- nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
  -- nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
  -- nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
  -- nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
  -- nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
  -- nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
  -- nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
  -- nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
end
