-- lua/plugins/fidget.lua
return {
  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",

    opts = {
      progress = {
        suppress_on_insert = true,
        ignore_done_already = true,
        display = {
          done_ttl = 3,
          done_icon = "✓",
          progress_icon = { "dots" },
        },
      },

      notification = {
        override_vim_notify = true,

        window = {
          border = "rounded",
          winblend = 10,
          x_padding = 1,
          y_padding = 1,
          max_height = 8,
        },
      },
    },

    config = function(_, opts)
      require("fidget").setup(opts)
    end,
  },
}
