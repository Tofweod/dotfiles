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
      "<leader>Ff",
      function()
        require("telescope.builtin").find_files({ hidden = true })
      end,
      desc = "Find Hidden Files(root dir)",
    },
    {
      "<leader>FF",
      function()
        require("telescope.builtin").find_files({ cwd = false, hidden = true })
      end,
      desc = "Find Hidden Files(cwd)",
    },
    {
      "<leader>fg",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Find Content",
    },
    {
      "<leader>/",
      function()
        require("telescope.builtin").current_buffer_fuzzy_find()
      end,
      desc = "Search Current Fuzzy",
    },
    {
      "<leader>fw",
      function()
        require("telescope.builtin").grep_string({ word_match = "-w" })
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
