return {
    { "stevearc/dressing.nvim",     opts = {} },
    {
        "rcarriga/nvim-notify",
        config = function()
            local notify = require("notify")
            notify.setup({
                timeout = 1000,
                background_colour = "#000000",
                icons = {
                    ERROR = "",
                    WARN = "",
                    INFO = "",
                    DEBUG = "",
                    TRACE = "✎",
                },
            })
            vim.notify = notify
        end
    },

    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
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
            require 'colorizer'.setup({
                DEFAULT_OPTIONS = {
                    RGB      = true, -- #RGB hex codes
                    RRGGBB   = true, -- #RRGGBB hex codes
                    names    = false, -- "Name" codes like Blue
                    RRGGBBAA = false, -- #RRGGBBAA hex codes
                    rgb_fn   = false, -- CSS rgb() and rgba() functions
                    hsl_fn   = false, -- CSS hsl() and hsla() functions
                    css      = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                    css_fn   = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                    -- Available modes: foreground, background
                    mode     = 'background', -- Set the display mode.
                }
            })
        end

    },
    {
        "lervag/vimtex",
        lazy = false,
        config = function()
        end
    },
    {
        'habamax/vim-godot',
    },
    {
        'RRethy/vim-illuminate',
    },
    {
        'jinh0/eyeliner.nvim',
        config = function()
            require 'eyeliner'.setup {
                highlight_on_key = true,
                dim = true,
            }
        end
    },
    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },
    { 'tzachar/highlight-undo.nvim' },
}
