local headers = {
    ["nvim"] = {
        "                                                     ",
        "                                                     ",
        "                                                     ",
        "                                                     ",
        "                                                     ",
        "                                                     ",
        "                                                     ",
        "                                                     ",
        "                                                     ",
        "                                                     ",
        "                                                     ",
        "                                                     ",
        "                                                     ",
        "                                                     ",
        "                                                     ",
        "                                                     ",
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ",
        "                                                     ",
        "                                                     ",
        "                                                     ",
        "                                                     ",
        "                                                     ",
        "                                                     ",
        "                                                     ",
        "                                                     ",
        "                                                     ",
    },
}

return
{
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                theme = 'doom',
                config = {
                    header = headers['nvim'],
                    center = {
                        { icon = "  ", desc = "Project Manager", key = "1", action = "Telescope project" },
                        { icon = "  ", desc = "Open Config", key = "2", action = "cd ~/AppData/Local/nvim/ | lua require('telescope.builtin').find_files() " },
                        { icon = "󰏘  ", desc = "Color Scheme", key = "3", action = "ColorSchemePicker()" },
                        { icon = "󱡔  ", desc = "Toggle Background", key = "4", action = "ToggleTransparentBg() ApplyColorScheme(vim.g.colors_name)" },
                    },
                },
                disable_move = false,
                shortcut_type = 'number',
                change_to_vcs_root = false,
                hide = {
                    statusline = false,
                    tabline = true,
                    winbar = true,
                },
                preview = {
                    file_path   = '',
                    file_height = vim.o.lines,
                    file_width  = vim.o.columns,
                },
            }
        end,
        dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    }
}
