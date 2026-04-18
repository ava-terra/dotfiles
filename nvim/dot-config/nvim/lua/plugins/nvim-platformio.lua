-- lua/plugins/platformio.lua
return {
  {
    "anurag3301/nvim-platformio.lua",

    dependencies = {
      "akinsho/toggleterm.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-lua/plenary.nvim",
      "folke/which-key.nvim",
      "nvim-treesitter/nvim-treesitter",
    },

    cmd = {
      "Pioinit",
      "Piorun",
      "Piocmdh",
      "Piocmdf",
      "Piolib",
      "Piomon",
      "Piodebug",
      "Piodb",
    },

    opts = {
      lsp = "clangd", -- value: clangd | ccls
      clangd_source = "ccls", -- value: ccls | compiledb
      clangd_flags = { "--background-index", "--clang-tidy", "--suggest-missing-includes" },
      -- menu_key = "<leader>\\",
      debug = false,
    },

    config = function(_, opts)
      -- Set the global config first (as the plugin expects)
      vim.g.pioConfig = opts

      -- Then setup the plugin
      local ok, platformio = pcall(require, "platformio")
      if ok then
        platformio.setup(vim.g.pioConfig)
      end
    end,
  },
}
