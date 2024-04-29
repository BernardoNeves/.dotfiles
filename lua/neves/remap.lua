vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pV", function()
    vim.cmd("e " .. vim.fn.getcwd())
end)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("t", "<ESC>", "[[<C-\\><C-n>]]")

vim.keymap.set("n", "<leader>w", "<C-W>")
vim.keymap.set("n", "<leader>W", "<C-W>w")
vim.keymap.set("n", "<leader>wV", ":vnew<CR>")
vim.keymap.set("n", "<leader>wS", ":new<CR>")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
-- e ~/AppData/Local/nvim/
vim.keymap.set("n", "<leader>vpp", "<cmd>cd ~/AppData/Local/nvim/<CR> <cmd>lua require('telescope.builtin').find_files()<CR>")
vim.keymap.set("n", "<leader>h", "<cmd>Dashboard<CR>")

vim.keymap.set("n", "<Up>", "<nop>")
vim.keymap.set("n", "<Down>", "<nop>")
vim.keymap.set("n", "<Left>", "<nop>")
vim.keymap.set("n", "<Right>", "<nop>")

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>")

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
