---@type NvPluginSpec
return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended
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

  keys = {
    { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "Obsidian: New Note", mode = "n" },
    { "<leader>ot", "<cmd>ObsidianToday<cr>", desc = "Obsidian: Today", mode = "n" },
    { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Obsidian: Backlinks", mode = "n" },
    { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Obsidian: Search Vault", mode = "n" },
    { "<leader>ol", "<cmd>ObsidianLinkNew<cr>", desc = "Obsidian: Link New Note", mode = "n" },
  },

  ft = "markdown",

  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  config = function()
    require("obsidian").setup {
      workspaces = {
        { name = "main", path = "~/areas/pkm/main/" },
        { name = "nnwn", path = "~/areas/norfolk_reform/" },
      },

      templates = {
        folder = "_config/template",
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

        -- Smart action moved here (safer)
        ["<leader>oo"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, desc = "Obsidian: Smart Action" },
        },
      },
    }
  end,
}
