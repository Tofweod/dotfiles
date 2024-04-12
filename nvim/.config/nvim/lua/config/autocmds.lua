-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    local function _trigger()
      vim.api.nvim_exec_autocmds("User", { pattern = "IceLoad" })
    end

    if vim.bo.filetype == "dashboard" then
      vim.api.nvim_create_autocmd("BufRead", {
        once = true,
        callback = _trigger,
      })
    else
      _trigger()
    end
  end,
})

-- smart indent
vim.cmd([[
autocmd FileType php,c,java,perl,shell,bash,vim,ruby,cpp set ai
autocmd FileType php,c,java,perl,shell,bash,vim,ruby,cpp set sw=4
autocmd FileType php,c,java,perl,shell,bash,vim,ruby,cpp set ts=4
autocmd FileType php,c,java,perl,shell,bash,vim,ruby,cpp set sts=4
]])

-- autoformat
vim.cmd([[
autocmd FileType c,cpp lua vim.b.autoformat=false
]])
