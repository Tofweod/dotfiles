return {
  "neovim/nvim-lspconfig",

  config = function()
    local lspconfig = require("lspconfig")

    -- C / C++
    vim.lsp.config("clangd", {
      cmd = {
        "clangd",
        "--compile-commands-dir=build/",
        "--query-driver=/usr/bin/gcc",
        "--log=verbose",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--all-scopes-completion",
      },
      filetypes = { "c", "cpp" },
      root_markers = {
        ".clangd",
        ".clang-tidy",
        ".clang-format",
        "compile_commands.json",
        "compile_flags.txt",
        "configure.ac", -- AutoTools
        ".git",
      },
    })

    -- CMake
    vim.lsp.config("cmake", {
      cmd = { "cmake-language-server" },
      filetypes = { "cmake" },
      init_options = {
        buildDirectory = "build",
      },
      root_markers = { "CMakePresets.json", "CTestConfig.cmake", ".git", "build", "cmake" },
    })

    -- Python
    vim.lsp.config("pyright", {
      cmd = { "pyright-langserver", "--stdio" },
      filetypes = { "python" },
      root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
        ".git",
      },
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "workspace",
            useLibraryCodeForTypes = true,
          },
        },
      },
      single_file_support = true,
    })

    -- Lua
    vim.lsp.config("lua_ls", {
      cmd = { "lua-language-server" },
      filetypes = { "lua" },
    })

    -- Autotools
    local util = require("lspconfig.util")
    local root_files = { "configure.ac", "Makefile", "Makefile.am", "*.mk" }

    vim.lsp.config("autotools_ls", {
      cmd = { "autotools-language-server" },
      filetypes = { "config", "automake", "make" },
      root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        on_dir(util.root_pattern(unpack(root_files))(fname))
      end,
    })

    -- Bash
    vim.lsp.config("bashls", {
      cmd = { "bash-language-server", "start" },
      filetypes = { "sh" },
      settings = {
        bashIde = {
          globPattern = "*@(.sh|.inc|.bash|.command)",
        },
      },
      single_file_support = true,
    })

    vim.lsp.enable({ "clangd", "cmake", "pyright", "lua_ls", "bashls", "autotools_ls" })
  end,
}
