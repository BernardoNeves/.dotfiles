return {
    'LunarVim/breadcrumbs.nvim',
    dependencies = {
        'SmiteshP/nvim-navic',
        'neovim/nvim-lspconfig',
    },
    config = function()
        require('breadcrumbs').setup()
        require('nvim-navic').setup()
    end

}
