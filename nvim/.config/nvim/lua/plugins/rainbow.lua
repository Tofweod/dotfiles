return {
  "hiphish/rainbow-delimiters.nvim",
  event = "LazyFile",
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
