return {
    {
        'theprimeagen/harpoon',
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")
            vim.keymap.set("n", "<leader>a", mark.add_file)
            vim.keymap.set("n", "<C-s>", ui.toggle_quick_menu)
            vim.keymap.set("n", "<C-w>", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<C-e>", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<C-m>", function() ui.nav_file(4) end)
        end
    },
    -- {
    --     'theprimeagen/harpoon',
    --     dependencies = { "nvim-lua/plenary.nvim" },
    --     branch = "harpoon2",
    --     priority = 100,
    --     settings = {
    --         save_on_toggle = true,
    --         sync_on_ui_close = true,
    --     },
    --     config = function()
    --         local harpoon = require("harpoon")
    --         harpoon:setup()
    --
    --         vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
    --         vim.keymap.set("n", "<C-s>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    --
    --         vim.keymap.set("n", "<C-w>", function() harpoon:list():select(1) end)
    --         vim.keymap.set("n", "<C-e>", function() harpoon:list():select(2) end)
    --         vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
    --         vim.keymap.set("n", "<C-m>", function() harpoon:list():select(4) end)
    --
    --         -- -- Toggle previous & next buffers stored within Harpoon list
    --         -- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
    --         -- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
    --     end
    -- }
}
