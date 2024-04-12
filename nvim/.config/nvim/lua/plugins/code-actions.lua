return {
  {
    "aznhe21/actions-preview.nvim",
    keys = {
      {
        "<leader>ca",
        function()
          require("actions-preview").code_actions()
        end,
        desc = "Code action",
      },
    },
    opts = {},
    -- config = function()
    --   vim.keymap.set({ "v", "n" }, "ca", require("actions-preview").code_actions)
    -- end,
  },
}
