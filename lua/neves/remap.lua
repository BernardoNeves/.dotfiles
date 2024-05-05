vim.g.mapleader = " "                         -- Set space as the map leader
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- Open netrw in the active directory
vim.keymap.set("n", "<leader>pV", function()  -- Open netrw in the current working directory
    vim.cmd("e " .. vim.fn.getcwd())
end)

-- Move selected lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Append next line to current line
vim.keymap.set("n", "J", "mzJ`z")

-- Center the cursor on scroll
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Center the cursor on search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Return to normal mode from terminal mode
vim.keymap.set("t", "<ESC>", "[[<C-\\><C-n>]]")

-- Pane management to avoid conflict with windows terminal, ik skill issue
vim.keymap.set("n", "<leader>w", "<C-W>")
vim.keymap.set("n", "<leader>W", "<C-W>w")
vim.keymap.set("n", "<leader>wV", ":vnew<CR>")
vim.keymap.set("n", "<leader>wS", ":new<CR>")

-- Paste and delete into void register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]]) -- Delete into void register


vim.keymap.set("i", "<C-c>", "<Esc>") -- Esc in insert mode

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format) -- Lsp formatting

-- Navigate quickfix list
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Substitute word under cursor, case-insensitive
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Open Telescope file finder starting from Neovim config directory
vim.keymap.set("n", "<leader>pc",
    "<cmd>cd ~/AppData/Local/nvim/<CR> <cmd>lua require('telescope.builtin').find_files()<CR>")

-- Open dashboard
vim.keymap.set("n", "<leader>h", "<cmd>Dashboard<CR>")

-- Disable arrow keys to force hjkl and character movement
vim.keymap.set({"n", "i"}, "<Up>", "<nop>")
vim.keymap.set({"n", "i"}, "<Down>", "<nop>")
vim.keymap.set({"n", "i"}, "<Left>", "<nop>")
vim.keymap.set({"n", "i"}, "<Right>", "<nop>")
vim.keymap.set({"n", "i"}, "<C-Up>", "<nop>")
vim.keymap.set({"n", "i"}, "<C-Down>", "<nop>")
vim.keymap.set({"n", "i"}, "<C-Left>", "<nop>")
vim.keymap.set({"n", "i"}, "<C-Right>", "<nop>")
vim.keymap.set({"n", "i"}, "<S-Up>", "<nop>")
vim.keymap.set({"n", "i"}, "<S-Down>", "<nop>")
vim.keymap.set({"n", "i"}, "<S-Left>", "<nop>")
vim.keymap.set({"n", "i"}, "<S-Right>", "<nop>")
vim.keymap.set({"n", "i"}, "<C-S-Up>", "<nop>")
vim.keymap.set({"n", "i"}, "<C-S-Down>", "<nop>")
vim.keymap.set({"n", "i"}, "<C-S-Left>", "<nop>")
vim.keymap.set({"n", "i"}, "<C-S-Right>", "<nop>")

-- Source current file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- Open Lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>")

-- Toggle Discord Rich Presence
local presenceEnabled = false;
local presence = require("presence");
function PresenceToggle()
    presenceEnabled = not presenceEnabled;
    if presenceEnabled then
        presence:update();
        vim.fn["presence#SetAutoCmds"]()
        vim.notify("Enabled Discord Rich Presence", vim.log.levels.INFO, { title = "Presence" })
        vim.cmd [[lua package.loaded.presence:update()]]
    else
        presence:cancel();
        vim.cmd [[autocmd! presence_events]]
        vim.notify("Disabled Discord Rich Presence", vim.log.levels.INFO, { title = "Presence" })
    end
end

vim.keymap.set("n", "<leader>dp", function() PresenceToggle() end);
