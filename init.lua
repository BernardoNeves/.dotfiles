require("neves")
vim.cmd [[
augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=50}
    autocmd InsertEnter * silent! lua vim.highlight.clear()
augroup END
]]

vim.cmd [[
    augroup AutoStartServer
        autocmd!
        autocmd! DirChanged * lua StartServer()
    augroup END
]]

function StartServer()
    local gdproject = io.open(vim.fn.getcwd() .. '/project.godot', 'r')
    if gdproject then
        vim.notify('Starting Godot Server')
        io.close(gdproject)
        vim.fn.serverstart('127.0.0.1:6666')
    else
        vim.fn.serverstop('127.0.0.1:6666')
    end
end
