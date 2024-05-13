return {
    -- {
    --     "letieu/harpoon-lualine",
    --     dependencies = {
    --         {
    --             "ThePrimeagen/harpoon",
    --             branch = "harpoon2",
    --         }
    --     },
    -- },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local function clock()
                local time = tostring(os.date()):sub(12, 16)
                -- if os.time() % 2 == 1 then time = time:gsub(":", " ") end -- make the `:` blink
                return time
            end;

            local settings = {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { 'filename' },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'selectioncount', 'location' }
                },
                tabline = {
                    lualine_a = { { 'windows', mode = 2 } },
                    lualine_b = { 'hostman' },
                    lualine_c = { {
                        function()
                            if package.loaded["nvim-navic"] and require("nvim-navic").is_available()
                            then
                                return require("nvim-navic").get_location()
                            else
                                return ""
                            end
                        end,
                    } },
                    lualine_x = {},
                    lualine_y = { clock, { 'datetime', style = 'uk' } },
                    lualine_z = { 'tabs' }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { 'filename' },
                    lualine_x = { 'filesize', 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
            }

            require('lualine').setup(settings)
        end,
    },
}
