-- lua/plugins/lspconfig.lua
return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",

    config = function()
      -- Load NvChad's default LSP settings (on_attach, capabilities, etc.)
      require("nvchad.configs.lspconfig").defaults()

      local servers = {
        "bashls",
        "clangd",
        "docker_compose_language_service",
        "cssls",
        "html",
        "jinja_lsp",
        "jsonls",
        "pyright",
        "svelte",
        "taplo",
      }

      vim.lsp.enable(servers)

      -- Custom config for specific servers
      vim.lsp.config.clangd = {
        cmd = { "clangd", "--compile-commands-dir=." },
      }
    end,
  },
}
