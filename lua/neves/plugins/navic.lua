return {
    {
        'SmiteshP/nvim-navic',
        dependencies = {
            'neovim/nvim-lspconfig',
        },
        config = function()
            require('nvim-navic').setup({
                highlight = true,
            })
            vim.g.navic_silence = true
        end
    },
    -- {
    --     'LunarVim/breadcrumbs.nvim',
    --     dependencies = {
    --         'SmiteshP/nvim-navic',
    --     },
    --     config = function()
    --         require('breadcrumbs').setup()
    --     end
    -- },
}
