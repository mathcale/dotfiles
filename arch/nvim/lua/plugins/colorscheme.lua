return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha',
      default_integrations = false,
    }

    vim.cmd.colorscheme 'catppuccin'
  end,
}
