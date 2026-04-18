-- lua/plugins/conform.lua
return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- Format on save
    cmd = { "ConformInfo" },

    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        rust = { "rustfmt" },
        terraform = { "terraform_fmt" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        html = { "prettierd" },
        scss = { "prettierd" },
        css = { "prettierd" },
        markdown = { "markdownlint" },
        sql = { "pg_format" },
        proto = { "buf" },
        python = { "black" },
        yaml = { "prettierd" },
      },

      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },

    config = function(_, opts)
      require("conform").setup(opts)
    end,
  },
}
