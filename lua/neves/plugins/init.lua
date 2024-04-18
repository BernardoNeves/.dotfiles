return {
    { "stevearc/dressing.nvim", opts = {} },
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            'nvim-notify',
            "rcarriga/nvim-notify",
        }
    },

    'uga-rosa/ccc.nvim',
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },

    {
        'folke/todo-comments.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
            require('todo-comments').setup()
        end
    },
    'github/copilot.vim',
    {
        'NvChad/nvim-colorizer.lua',
        config = function()
            require 'colorizer'.setup()
        end
    },
}
