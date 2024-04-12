return {
  "hiphish/rainbow-delimiters.nvim",
  event = "User IceLoad",
  config = function()
    require("rainbow-delimiters.setup").setup({
      strategy = {
        -- ...
      },
      query = {
        -- ...
      },
      highlight = {
        -- ...
      },
    })
  end,
}
