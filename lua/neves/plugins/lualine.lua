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
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = function()
            local function clock()
                local time = tostring(os.date()):sub(12, 16)
                if os.time() % 2 == 1 then time = time:gsub(":", " ") end -- make the `:` blink
                return time
            end;

            local function lsp_progress()
                local messages = vim.lsp.util.get_progress_messages()
                if #messages == 0 then
                    return
                end
                local status = {}
                for _, msg in pairs(messages) do
                    table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
                end
                local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
                local ms = vim.loop.hrtime() / 1000000
                local frame = math.floor(ms / 120) % #spinners
                return table.concat(status, " | ") .. " " .. spinners[frame + 1]
            end;

            require('lualine').setup({
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { 'filename' },
                    lualine_d = { require('gitsigns').get_git_info },
                    -- lualine_h = { 'harpoon2', {
                    --     "harpoon2",
                    --     indicators = { "w", "e", "n", "m" },
                    --     active_indicators = { "W", "E", "N", "M" },
                    --     no_harpoon = "Harpoon not loaded",
                    --
                    -- } },
                    lualine_v = { lsp_progress },
                    lualine_w = { clock },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {}
                },
            })
        end
    },
}
