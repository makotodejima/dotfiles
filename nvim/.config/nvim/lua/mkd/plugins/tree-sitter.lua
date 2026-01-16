return {
  "nvim-treesitter/nvim-treesitter",
  event = "VeryLazy",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    -- {
    --   "nvim-treesitter/playground",
    --   lazy = true,
    -- },
    { "nvim-treesitter/nvim-treesitter-textobjects", lazy = true },
  },
  config = function()
    local tree_sitter_configs = require("nvim-treesitter.configs")
    tree_sitter_configs.setup({
      ensure_installed = {
        "bash",
        "c",
        "comment",
        "cpp",
        "css",
        "diff",
        "dockerfile",
        "dot",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "graphql",
        "hcl",
        "hlsl",
        "html",
        "hurl",
        "java",
        "javascript",
        "jq",
        "jsdoc",
        "json",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "requirements",
        "rust",
        "scss",
        "sql",
        "swift",
        "terraform",
        "todotxt",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      indent = { enable = true },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = function(lang, buf)
          local count = vim.api.nvim_buf_line_count(buf)
          return count > 50000
        end,
      },
      incremental_selection = {
        enable = true,
        keymaps = { node_incremental = "ni", node_decremental = "nd" },
      },
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            -- ["ac"] = "@class.outer",
            -- You can optionally set descriptions to the mappings (used in the desc parameter of
            -- nvim_buf_set_keymap) which plugins like which-key display
            -- ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            -- You can also use captures from other query groups like `locals.scm`
            -- ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
          },
          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          -- selection_modes = {
          --   ["@parameter.outer"] = "v", -- charwise
          --   ["@function.outer"] = "V", -- linewise
          --   ["@class.outer"] = "<c-v>", -- blockwise
          -- },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true or false
          include_surrounding_whitespace = true,
        },
      },
    })
    require("treesitter-context").setup({
      enable = true,
      max_lines = 12,
    })
    vim.keymap.set("n", "[s", function()
      require("treesitter-context").go_to_context(vim.v.count1)
    end)
  end,
}
