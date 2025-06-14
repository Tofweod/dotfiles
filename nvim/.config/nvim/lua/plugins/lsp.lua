return {
  "neovim/nvim-lspconfig",

  config = function()
    local lspconfig = require("lspconfig")

    lspconfig.clangd.setup({
      -- 配置语言服务器的其他参数（可选）
      cmd = {
        "clangd",
        "--compile-commands-dir=build/",
        "--query-driver=/usr/bin/gcc",
        "--log=verbose",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--all-scopes-completion",
      }, -- 可以根据你的需求添加其他参数
      filetypes = { "c", "cpp" }, -- 支持的文件类型
      root_dir = lspconfig.util.root_pattern(".git", "compile_commands.json", ".root"),
    })

    lspconfig.cmake.setup({
      cmd = { "cmake-language-server" },
      filetypes = { "cmake" },
      init_options = {
        buildDirectory = "build",
      },
      root_dir = lspconfig.util.root_pattern(".git", "CMakeLists.txt"),
    })

    lspconfig.pyright.setup({
      cmd = { "pyright-langserver", "--stdio" },
      filetypes = { "python" },
      root_dir = function(filename)
        local root_files = {
          "WORKSPACE",
          "pyproject.toml",
          "setup.py",
          "setup.cfg",
          "requirements.txt",
          "Pipfile",
          "pyrightconfig.json",
        }
        return lspconfig.util.root_pattern(unpack(root_files))(filename) or lspconfig.util.path.dirname(filename)
      end,
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

    lspconfig.lua_ls.setup({})

    lspconfig.autotools_ls.setup({
      cmd = { "autotools-language-server" },
      filetypes = {
        "config",
        "automake",
        "make",
      },
      root_dir = lspconfig.util.root_pattern("configure.ac", "Makefile", "Makefile.am", "*.mk"),
      single_file_support = true,
    })

    lspconfig.bsl_ls.setup({
      cmd = { "bash-language-server", "start" },
      filetypes = { "sh" },
      settings = {
        bashIde = {
          globPattern = "*@(.sh|.inc|.bash|.command)",
        },
      },
      single_file_support = true,
    })
  end,
}
