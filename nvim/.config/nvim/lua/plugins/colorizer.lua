return {
  "norcalli/nvim-colorizer.lua",
  event = "User IceLoad",
  config = function()
    require("colorizer").setup()
  end,
}
