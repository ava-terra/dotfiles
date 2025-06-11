local options = {
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
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
