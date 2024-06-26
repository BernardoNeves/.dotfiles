return {
    'hrsh7th/nvim-cmp',
    priority = 40,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
    },
    config = function()
        local cmp = require 'cmp'
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        local devicons = require('nvim-web-devicons')
        cmp.register_source('devicons', {
            complete = function(self, params, callback)
                local items = {}
                for _, icon in pairs(devicons.get_icons()) do
                    table.insert(items, {
                        label = icon.icon .. '  ' .. icon.name,
                        insertText = icon.icon,
                        filterText = icon.name,
                    })
                end
                callback({ items = items })
            end,
        })
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            })
        })
    end
}
