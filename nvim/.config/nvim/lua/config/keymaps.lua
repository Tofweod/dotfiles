-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Keymaps are automatically loaded on the VeryLazy event
-- Add any additional keymaps here
--

local keymap = vim.keymap
local wk = require("which-key")

-- 取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- 标准模式回车
-- keymap.set("n", "<CR>", "o<ESC><CR>")

-- 文件保退出
keymap.set("n", "<leader>w", ":w<CR>")
keymap.set("n", "<leader>q", ":q<CR>")
keymap.set("n", "<leader>wq", ":wq<CR>")

-- 窗口
wk.register({
  ["<leader>"] = {
    w = {
      name = "+windows",
      v = { "<C-w>s", "split windows vertical" },
      h = { "<C-w>v", "split windows horizontal" },
    },
  },
})

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

-- trouble
wk.register({
  ["<leader>"] = {
    x = {
      name = "+diagnostics/quickfix",
      x = {
        function()
          require("trouble").toggle()
        end,
        "Document Diagnostics(Troule)",
      },
      X = {
        function()
          require("trouble").toggle("workspace_diagnostics")
        end,
        "Workspace Diagnostics(Troule)",
      },
    },
  },
})
-- keymap.set("n", "gr", function()
--   require("trouble").toggle("lsp_references")
-- end)

wk.register({
  g = {
    r = {
      function()
        require("trouble").toggle("lsp_references")
      end,
      "Go to references",
    },
    ["["] = { vim.diagnostic.goto_prev, "Go to prev" },
    ["]"] = { vim.diagnostic.goto_next, "Go to next" },
  },
})

-- vim.keymap.set("n", "g[", vim.diagnostic.goto_prev)
-- vim.keymap.set("n", "g]", vim.diagnostic.goto_next)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    wk.register({
      g = {
        D = { vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts), "Go to declaration" },
        d = { vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts), "Go to definition" },
        h = { vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts), "show hover" },
        i = { vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts), "go to implementation" },
        -- f = {
        --   function()
        --     vim.lsp.buf.format({ range = nil })
        --   end,
        --   "Lsp format all",
        -- },
        -- F = {
        --   function()
        --     vim.lsp.buf.format({ async = true })
        --   end,
        --   "Lsp format selected",
        -- },
      },
    })
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
