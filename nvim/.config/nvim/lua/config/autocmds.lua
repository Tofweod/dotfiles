-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- smart indent
vim.cmd([[
autocmd FileType php,c,java,perl,shell,bash,vim,ruby,cpp set ai
autocmd FileType php,c,java,perl,shell,bash,vim,ruby,cpp set sw=4
autocmd FileType php,c,java,perl,shell,bash,vim,ruby,cpp set ts=4
autocmd FileType php,c,java,perl,shell,bash,vim,ruby,cpp set sts=4
autocmd FileType python,javascript,html,css,xml set ai
autocmd FileType python,javascript,html,css,xml set sw=2
autocmd FileType python,javascript,html,css,xml set ts=2
autocmd FileType python,javascript,html,css,xml set sts=2
]])
