-- •
-- left aligned solid
-- • `▏`
-- • `▎` (default)
-- • `▍`
-- • `▌`
-- • `▋`
-- • `▊`
-- • `▉`
-- • `█`
-- •
-- center aligned solid
-- • `│`
-- • `┃`
-- •
-- right aligned solid
-- • `▕`
-- • `▐`
-- •
-- center aligned dashed
-- • `╎`
-- • `╏`
-- • `┆`
-- • `┇`
-- • `┊`
-- • `┋`
-- •
-- center aligned double
-- • `║`

return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function()
        require("ibl").setup {
            scope = { enabled = false },
            exclude = { filetypes = { "dashboard" } },
            indent = {
                char = "▏",
                tab_char = "•",
                smart_indent_cap = true,
                highlight = { "Function", "Label" },
            },
        }
    end
}
