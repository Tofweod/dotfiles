-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Keymaps are automatically loaded on the VeryLazy event
-- Add any additional keymaps here
--

local keymap = vim.keymap

-- 取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- 标准模式回车
-- keymap.set("n", "<CR>", "o<ESC><CR>")

-- 文件保退出
keymap.set("n", "<leader>w", ":w<CR>")
keymap.set("n", "<leader>q", ":q<CR>")
keymap.set("n", "<leader>wq", ":wq<CR>")

-- 窗口
keymap.set("n", "<leader>sv", "<C-w>v")
keymap.set("n", "<leader>sh", "<C-w>s")

-- buffline
keymap.set("n", "<leader><leader>h", ":bprevious<CR>")
keymap.set("n", "<leader><leader>l", ":bnext<CR>")
keymap.set("n", "<leader><leader>d", ":bdelete<CR>")
keymap.set("n", "<A-1>", ":BufferLineGoToBuffer 1<CR>")
keymap.set("n", "<A-2>", ":BufferLineGoToBuffer 2<CR>")
keymap.set("n", "<A-3>", ":BufferLineGoToBuffer 3<CR>")
keymap.set("n", "<A-4>", ":BufferLineGoToBuffer 4<CR>")
keymap.set("n", "<A-5>", ":BufferLineGoToBuffer 5<CR>")
keymap.set("n", "<A-6>", ":BufferLineGoToBuffer 6<CR>")
keymap.set("n", "<A-7>", ":BufferLineGoToBuffer 7<CR>")
keymap.set("n", "<A-8>", ":BufferLineGoToBuffer 8<CR>")
keymap.set("n", "<A-9>", ":BufferLineGoToBuffer 9<CR>")
keymap.set("n", "<A-0>", ":BufferLineGoToBuffer 10<CR>")

-- 插件
-- nvim-tree
-- keymap.set("n", "<leader>tr", ":NvimTreeToggle<CR>")

-- hop
keymap.set("n", "<leader>hw", ":HopWord<CR>")
keymap.set("n", "<leader>hc", ":HopChar1<CR>")
keymap.set("n", "<leader>hl", ":HopLine<CR>")
keymap.set("n", "<leader>ha", ":HopAnywhere<CR>")

-- trouble
keymap.set("n", "<leader>xx", function()
  require("trouble").toggle()
end)
keymap.set("n", "<leader>xw", function()
  require("trouble").toggle("workspace_diagnostics")
end)
keymap.set("n", "<leader>xd", function()
  require("trouble").toggle("document_diagnostics")
end)
keymap.set("n", "<leader>xq", function()
  require("trouble").toggle("quickfix")
end)
keymap.set("n", "<leader>xl", function()
  require("trouble").toggle("loclist")
end)
keymap.set("n", "gr", function()
  require("trouble").toggle("lsp_references")
end)

vim.keymap.set("n", "g[", vim.diagnostic.goto_prev)
vim.keymap.set("n", "g]", vim.diagnostic.goto_next)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("v", "gf", function()
      vim.lsp.buf.format({ range = nil })
    end, opts)
    vim.keymap.set("n", "gF", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})

-- aerial
keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")

-- markdownpreview
keymap.set("n", "<leader>md", "<Plug>MarkdownPreviewToggle")
