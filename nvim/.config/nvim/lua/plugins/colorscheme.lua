return {
  -- manual installed colorscheme belows
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
  },

  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "moon" },
  },

  {
    "marko-cerovac/material.nvim",
    lazy = true,
  },

  -- set the default colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
