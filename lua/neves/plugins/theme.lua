local popup = require('plenary.popup')
local current_color = vim.g.colors_name
local transparent_bg = false

local function saveSelectedColorScheme(color)
    local f = io.open(vim.fn.stdpath('config') .. '/selected_colorscheme.txt', 'w')
    if f then
        f:write(color)
        f:close()
    end
end

local function loadSelectedColorScheme()
    local f = io.open(vim.fn.stdpath('config') .. '/selected_colorscheme.txt', 'r')
    if f then
        local color = f:read('*all')
        f:close()
        return color
    end
    return nil
end


function ApplyColorScheme(color)
    vim.cmd.colorscheme(color)
    require('lualine').setup()
    if transparent_bg then
        vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    end
end

function ToggleTransparentBg()
    transparent_bg = not transparent_bg
end

function SelectColorScheme(color)
    current_color = color
    ApplyColorScheme(color)
    vim.notify('Changed to ' .. color, vim.log.levels.INFO, { title = 'ColorScheme' })
    saveSelectedColorScheme(color)
end

function CloseColorSchemePicker()
    vim.api.nvim_win_close(vim.api.nvim_get_current_win(), true)
    ApplyColorScheme(current_color)
end

function ColorSchemePicker()
    local color_schemes = vim.fn.getcompletion('', 'color')
    local blackList = {
        'OceanicNextLight',
        'bamboo',
        'bamboo-light',
        'bamboo-multiplex',
        'catppuccin',
        'catppuccin-frappe',
        'catppuccin-latte',
        'catppuccin-macchiato',
        'dawnfox',
        'dayfox',
        'default',
        'dracula-soft',
        'github_dark',
        'github_dark_colorblind',
        'github_dark_dimmed',
        'github_dark_high_contrast',
        'github_dark_tritanopia',
        'github_dimmed',
        'github_light',
        'github_light_colorblind',
        'github_light_default',
        'github_light_high_contrast',
        'github_light_tritanopia',
        'kanagawa',
        'kanagawa-dragon',
        'kanagawa-lotus',
        'material',
        'material-darker',
        'material-lighter',
        'material-oceanic',
        'material-palenight',
        'nordfox',
        'onedark',
        'onelight',
        'onenord-light',
        'rose-pine',
        'rose-pine-dawn',
        'terafox',
        'tokyonight',
        'tokyonight-day',
    }

    for i = #color_schemes, 1, -1 do
        if vim.tbl_contains(blackList, color_schemes[i]) then
            table.remove(color_schemes, i)
        end
    end

    local win_height = math.max(1, #color_schemes)
    local win_width = 40
    local row = math.floor((vim.api.nvim_get_option('lines') - win_height) / 2)
    local col = math.floor((vim.api.nvim_get_option('columns') - win_width) / 2)

    local buffer = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buffer, 'buftype', 'nofile')
    vim.api.nvim_buf_set_option(buffer, 'bufhidden', 'wipe')
    vim.api.nvim_buf_set_option(buffer, 'buflisted', false)
    vim.api.nvim_buf_set_option(buffer, 'filetype', 'lua')
    vim.api.nvim_buf_set_lines(buffer, 0, -1, false, color_schemes)
    vim.api.nvim_buf_set_option(buffer, 'modifiable', false)

    local win = popup.create(buffer, {
        title = 'Color Schemes' .. ' (' .. current_color .. ')',
        border = true,
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        line = row,
        col = col,
        width = win_width,
        height = win_height,
        padding = { 1, 1, 1, 1 },
        highlight = 'Normal:NormalFloat',
        borderhighlight = 'Normal:NormalFloat',
    })
    vim.api.nvim_win_set_option(win, 'winhighlight', 'Normal:NormalFloat')
    vim.api.nvim_win_set_buf(win, buffer)

    for i, v in ipairs(color_schemes) do
        if v == current_color then
            vim.api.nvim_win_set_cursor(0, { i, 0 })
            break
        end
    end

    vim.api.nvim_buf_set_keymap(buffer, 'n', 'q', '<cmd>lua vim.api.nvim_win_close(' .. win .. ', true)<CR>',
        { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buffer, 'n', '<Esc>', '<cmd>lua vim.api.nvim_win_close(' .. win .. ', true)<CR>',
        { noremap = true, silent = true })

    vim.cmd(
        "autocmd CursorMoved <buffer> lua ApplyColorScheme(vim.api.nvim_buf_get_lines(0, vim.fn.line('.')-1, vim.fn.line('.'), false)[1])"
    )
    vim.cmd(
        "autocmd BufLeave <buffer> silent lua CloseColorSchemePicker()"
    )
    vim.api.nvim_buf_set_keymap(
        buffer, 'n', '<CR>',
        '<cmd>lua SelectColorScheme(vim.fn.getline("."))<CR>' ..
        '<cmd>lua vim.api.nvim_win_close(' .. win .. ', true)<CR>',
        { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
        buffer, 'n', '<C-p>',
        '<cmd>lua if vim.fn.line(".") > 1 then vim.api.nvim_win_set_cursor(0, {vim.fn.line(".") - 1, 0}) end<CR>',
        { noremap = true, silent = true }
    )
end

local init = function()
    local color = loadSelectedColorScheme()
    if color == nil or color == '' then
        vim.notify('No color scheme selected, using default', vim.log.levels.WARN, { title = 'ColorScheme' })
        color = 'tokyonight-night'
        saveSelectedColorScheme(color)
    end
    ApplyColorScheme(color)
    current_color = color
end

vim.keymap.set('n', '<leader>cs', ColorSchemePicker)
vim.keymap.set('n', '<leader>ct',
    '<cmd>lua ToggleTransparentBg()<CR> <cmd> lua ApplyColorScheme(vim.g.colors_name)<CR>')

vim.cmd([[autocmd ColorScheme * lua ApplyColorScheme(vim.g.colors_name)]])

return {
    {
        'mhartington/oceanic-next',
        lazy = false,
        priority = 1000,
    },
    {
        'projekt0n/github-nvim-theme',
        lazy = false,
        priority = 1000,
        config = function()
            require('github-theme').setup({
            })
        end,
    },
    {
        'Mofiqul/dracula.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('dracula').setup({
                italic_comment = false,
            })
        end
    },
    {
        'ribru17/bamboo.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('bamboo').setup({
                style = 'vulgaris',
                code_style = {
                    comments = { italic = false },
                    conditionals = { italic = false },
                    namespaces = { italic = false },
                    parameters = { italic = false },
                },
            }
            )
        end,
    },
    {
        'nyoom-engineering/oxocarbon.nvim',
        lazy = false,
        priority = 1000,

    },
    {
        'olimorris/onedarkpro.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('onedarkpro').setup({
                theme = 'darker',
                styles = {
                    comments = 'NONE',
                },
            })
        end,
    },
    {
        'Mofiqul/vscode.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('vscode').setup({
                italic_comments = false,
            })
        end,
    },
    {
        'catppuccin/nvim',
        lazy = false,
        priority = 1000,
        name = 'catppuccin',
        require('catppuccin').setup({
            transparent_background = false,
            dim_inactive = {
                enabled = false,
                shade = 'dark',
                percentage = 0.15,
            },
            no_italic = true,
            no_bold = false,
            no_underline = false,
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                notify = true,
            },
            styles = {
                comments = {},
                conditionals = {},
            },
        })

    },
    {
        'marko-cerovac/material.nvim',
        lazy = false,
        priority = 1000,
        name = 'material',
        config = function()
            require('material').setup({
                plugins = {
                    'fidget',
                    'gitsigns',
                    'harpoon',
                    'indent-blankline',
                    'noice',
                    'nvim-cmp',
                    'nvim-web-devicons',
                    'telescope',
                    'trouble',
                    'nvim-notify',
                }
            })
        end
    },
    {
        'rose-pine/neovim',
        lazy = false,
        priority = 1000,
        name = 'rose-pine',
        config = function()
            require('rose-pine').setup({
                disable_background = transparent_bg,
                styles = {
                    italic = false,
                },
            })
        end
    },
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        priority = 1000,
        name = 'kanagawa',
        config = function()
            require('kanagawa').setup({
                compile = false,
                undercurl = true,
                commentStyle = { italic = false },
                keywordStyle = { italic = false },
                statementStyle = { bold = true },
                typeStyle = {},
                transparent = transparent_bg,
                dimInactive = false,
                terminalColors = true,
                theme = 'wave',
                background = {
                    dark = 'wave',
                    light = 'lotus'
                },
            })
        end,
    },
    {
        'navarasu/onedark.nvim',
        lazy = false,
        priority = 1000,
        name = 'onedark',
        config = function()
            require('onedark').setup {
                style = 'dark', -- warmer
                transparent = transparent_bg,
                term_colors = true,
                code_style = {
                    comments = 'none',
                    keywords = 'none',
                }

            }
        end,
    },
    {
        'EdenEast/nightfox.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('nightfox').setup({
                options = {
                    transparent = transparent_bg,
                    terminal_colors = true,
                    styles = {
                        comments = 'NONE',
                        keywords = 'bold',
                        types = 'bold',
                    }
                },
            })
        end,
    },
    {
        'tiagovla/tokyodark.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('tokyodark').setup({
                transparent_background = transparent_bg,
                disable_background = transparent_bg,
                terminal_colors = true,
                styles = {
                    comments = { italic = false },
                    keywords = { italic = false },
                    identifiers = { italic = false },
                    functions = {},
                    variables = {},
                },
            })
        end
    },
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('tokyonight').setup({
                style = 'night',
                transparent = transparent_bg,
                disable_background = transparent_bg,
                terminal_colors = true,
                styles = {
                    comments = { italic = false },
                    keywords = { italic = false },
                    identifiers = { italic = false },
                    sidebars = 'dark',
                    floats = 'dark',
                },
            })
            init() -- INFO: Append to last loaded color scheme
        end
    },
}
