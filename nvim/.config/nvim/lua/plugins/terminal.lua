return {
  "akinsho/toggleterm.nvim",
  version = "v2.*",
  event = "VeryLazy",
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
