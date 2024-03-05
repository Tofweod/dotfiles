return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        -- ["javascript"] = { "prettier" },
        -- ["javascriptreact"] = { "prettier" },
        -- ["typescript"] = { "prettier" },
        -- ["typescriptreact"] = { "prettier" },
        -- ["vue"] = { "prettier" },
        -- ["css"] = { "prettier" },
        -- ["scss"] = { "prettier" },
        -- ["less"] = { "prettier" },
        -- ["html"] = { "prettier" },
        ["json"] = { "prettier" },
        -- ["jsonc"] = { "prettier" },
        ["yaml"] = { "prettier" },
        ["markdown"] = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
        -- ["graphql"] = { "prettier" },
        -- ["handlebars"] = { "prettier" },
        ["python"] = { "black" },
      },
      formatters = {
        black = {
          prepend_args = { "-S", "-l", "79" },
        },
        prettier = {
          -- TODO:
          prepend_args = {},
        },
      },
      notify_on_error = false,
    },
  },
}
