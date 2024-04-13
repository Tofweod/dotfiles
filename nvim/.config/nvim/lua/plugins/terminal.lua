return {
  "akinsho/toggleterm.nvim",
  version = "v2.*",
  keys = {
    { "<c-\\>", "<cmd>ToggleTerm<CR>", desc = "Toggle term" },
  },
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<c-\>]],
      autochdir = true,
      start_in_insert = true,
      direction = "horizontal",
      winbar = {
        enabled = true,
      },
    })
  end,
}
