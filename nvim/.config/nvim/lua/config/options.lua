-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = " "

local opt = vim.opt

-- 行号
opt.relativenumber = true
opt.number = true

-- 缩进
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- 防包裹
opt.wrap = false

-- 光标行
opt.cursorline = true

-- 启用鼠标
opt.mouse:append("a")

-- 系统剪贴板
opt.clipboard:append("unnamedplus")

-- 搜索
opt.ignorecase = true
opt.smartcase = true

-- 外观
opt.termguicolors = true
opt.signcolumn = "yes"

-- vista
vim.g.vista_default_executive = "ctags"
vim.g.vista_icon_indent = { "▸ ", "" }
vim.g.vista_update_on_text_changed = 1
vim.g.vista_echo_cursor = 0
vim.g.vista_executive_for = {
  cpp = "nvim_lsp",
  python = "nvim_lsp",
  lua = "nvim_lsp",
}

-- spellcheck
vim.opt.spell = true
vim.opt.spelllang = { "en_us", "cjk" }
vim.opt.spelloptions = "camel"
-- vim.opt.spellfile = "/usr/share/nvim/runtime/spell/en.utf-8.spl"
