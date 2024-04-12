return {
  "sustech-data/wildfire.nvim",
  event = "User IceLoad",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("wildfire").setup()
  end,
}
