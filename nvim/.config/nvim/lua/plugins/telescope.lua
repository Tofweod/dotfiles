return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>fh",
      function()
        require("telescope.builtin").oldfiles()
      end,
      desc = "Find History",
    },
    {
      "<leader>fg",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Find Word",
    },
    {
      "<leader>fb",
      function()
        require("telescope.builtin").buffers()
      end,
      desc = "Find Buffers",
    },
    {
      "<leader>fc",
      function()
        require("telescope.builtin").colorscheme()
      end,
      desc = "Change Colorscheme",
    },
    {
      "<leader>fH",
      function()
        require("telescope.builtin").help_tags()
      end,
      desc = "Telescope Help",
    },
  },
}
