return {
  "lewis6991/gitsigns.nvim",
  keys = {
    {
      "<leader>ghd",
      function()
        require("gitsigns").diffthis()
      end,
      desc = "git diff",
    },
  },
  config = function()
    require("gitsigns").setup({})
  end,
}
