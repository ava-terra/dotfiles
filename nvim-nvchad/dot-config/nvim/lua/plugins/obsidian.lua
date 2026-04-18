-- lua/plugins/obsidian.lua
return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended: use latest stable release
    lazy = true,

    cmd = {
      "ObsidianNew",
      "ObsidianToday",
      "ObsidianYesterday",
      "ObsidianTomorrow",
      "ObsidianSearch",
      "ObsidianQuickSwitch",
      "ObsidianLink",
      "ObsidianLinkNew",
      "ObsidianBacklinks",
      "ObsidianTags",
      "ObsidianTemplate",
      "ObsidianOpen",
      "ObsidianWorkspace",
      "ObsidianRename",
      "ObsidianPasteImg",
    },

    ft = "markdown",

    -- Uncomment this if you want to load Obsidian only inside your vaults
    -- event = {
    --   "BufReadPre ~/areas/pkm/main/*.md",
    --   "BufReadPre ~/areas/norfolk_reform/*.md",
    --   "BufNewFile ~/areas/pkm/main/*.md",
    --   "BufNewFile ~/areas/norfolk_reform/*.md",
    -- },

    dependencies = {
      "nvim-lua/plenary.nvim",
    },

    opts = {
      workspaces = {
        {
          name = "main",
          path = "~/areas/pkm/main/",
        },
        {
          name = "nnwn",
          path = "~/areas/norfolk_reform/",
        },
      },

      templates = {
        folder = "Templates", -- Make sure this folder exists in your vault
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        substitutions = {},
      },

      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },

      ui = {
        enable = true,
        checkboxes = {
          [" "] = { char = "☐", hl_group = "ObsidianTodo" },
          ["x"] = { char = "✔", hl_group = "ObsidianDone" },
          [">"] = { char = "→", hl_group = "ObsidianRightArrow" },
          ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        },
        bullets = { char = "•" },
        external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
      },

      mappings = {
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        ["<leader>oo"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true },
        },
      },
    },

    config = function(_, opts)
      require("obsidian").setup(opts)
    end,
  },
}
