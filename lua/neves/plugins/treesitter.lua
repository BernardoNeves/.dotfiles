return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = { "javascript", "typescript", "python", "c", "lua", "vim", "vimdoc", "query" },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            }
        end,
    },
    -- {
    --     'nvim-treesitter/nvim-treesitter-context',
    --     config = function()
    --         require 'treesitter-context'.setup {
    --             enable = true,
    --             max_lines = 1,
    --             min_window_height = 0,
    --             line_numbers = true,
    --             multiline_threshold = 20,
    --             trim_scope = 'outer',
    --             mode = 'cursor',
    --             separator = nil,
    --             zindex = 20,
    --             on_attach = nil,
    --         }
    --     end,
    -- }
}
