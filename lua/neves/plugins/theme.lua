function ApplyColorScheme(color)
    color = color or 'tokyonight-night'
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

vim.cmd([[autocmd ColorScheme * lua ApplyColorScheme(vim.g.colors_name)]])

return {
    {
        priority = 1000,
        'catppuccin/nvim',
        name = 'catppuccin',

    },
    {
        priority = 1000,
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            require('rose-pine').setup({
                disable_background = true,
            })
        end
    },
    {
        priority = 1000,
        'rebelot/kanagawa.nvim',
        name = 'kanagawa',
        config = function()
            require('kanagawa').setup({
                compile = false,
                undercurl = true,
                commentStyle = { italic = false },
                functionStyle = {},
                keywordStyle = { italic = false },
                statementStyle = { bold = true },
                typeStyle = {},
                transparent = true,
                dimInactive = false,
                terminalColors = true,
                theme = "wave",
                background = {
                    dark = "wave",
                    light = "lotus"
                },
            })
        end,
    },
    {
        priority = 1000,
        'navarasu/onedark.nvim',
        name = 'onedark',
        config = function()
            require('onedark').setup {
                style = 'dark', -- warmer
                transparent = true,
                term_colors = true,
                code_style = {
                    comments = 'none',
                    keywords = 'none',
                }

            }
        end,
    },
    {
        priority = 1000,
        'EdenEast/nightfox.nvim',
        name = 'nightfox',
        config = function()
            require('nightfox').setup({
                options = {
                    transparent = true,
                    terminal_colors = true,
                },
            })
        end,
    },
    {
        priority = 1000,
        'folke/tokyonight.nvim',
        config = function()
            require('tokyonight').setup({
                style = 'night',
                transparent = true,
                terminal_colors = true,
                styles = {
                    comments = { italic = false },
                    keywords = { italic = false },
                    sidebars = 'dark',
                    floats = 'dark',
                },
            })
            ApplyColorScheme('tokyonight')
        end
    },
}
