return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
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
        "rust",
        "sql",
        "terraform",
        "todotxt",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
      highlight = { enable = true },
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
