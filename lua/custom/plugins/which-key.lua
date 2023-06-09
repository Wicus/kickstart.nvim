return {
  'folke/which-key.nvim',
  opts = {
    defaults = {
      mode = { 'n', 'v' },
      ['<leader>t'] = { name = 'toggle' },
    },
  },
  config = function()
    vim.opt.timeout = true
    vim.opt.timeoutlen = 300
    require('which-key').setup {}
  end,
}
