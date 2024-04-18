require("neves")
vim.cmd [[
augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=50}
    autocmd InsertEnter * silent! lua vim.highlight.clear()
augroup END
]]

