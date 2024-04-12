return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  ft = { "c", "cpp", "lua", "python" },
  config = function()
    require("lspsaga").setup({
      symbols_in_winbar = {
        enable = true,
        show_file = false,
      },
      finder = {
        max_height = 0.6,
        left_width = 0.3,
        right_width = 0.6,
      },
      outline = {
        win_position = "right",
        win_width = 25,
        detail = false,
        auto_close = true,
        close_after_jump = false,
      },
      code_action = {
        extend_gitsigns = true,
      },
    })
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons", -- optional
  },
}
