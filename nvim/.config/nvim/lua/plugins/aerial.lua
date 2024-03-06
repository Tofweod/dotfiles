return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  config = function()
    require("aerial").setup({
      layout = {
        default_direction = "right",
        placement = "window",
        resize_to_cotent = true,
      },

      filter_kind = {
        "Class",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Module",
        "Method",
        "Struct",
      },

      attach_mode = "window",

      close_automatic_events = {
        "unfocus",
        "unsupported",
      },
    })
  end,
}
