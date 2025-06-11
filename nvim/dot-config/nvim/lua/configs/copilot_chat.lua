-- ~/.config/nvim/lua/configs/copilot_chat.lua
return {
  question_header = "󰚩 ",
  answer_header = " ",
  window = {
    layout = "vertical", -- Floating chat window
    width = 0.5, -- 50% of window width
    height = 1, -- 100% of window height
  },
  prompts = {
    Explain = {
      prompt = "Write an explanation for the selected code as paragraphs of text.",
      system_prompt = "COPILOT_EXPLAIN",
    },
    Review = {
      prompt = "Review the selected code.",
      system_prompt = "COPILOT_REVIEW",
    },
    Fix = {
      prompt = "There is a problem in this code. Identify the issues and rewrite the code with fixes. Explain what was wrong and how your changes address the problems. If there are multiple changes, present the diffs sequentially from the end of the file to the beginning to avoid line number conflicts.",
    },
    Optimize = {
      prompt = "Optimize the selected code to improve performance and readability. Explain your optimization strategy and the benefits of your changes.",
    },
    Docs = {
      prompt = "Please add documentation comments to the selected code.",
    },
    Tests = {
      prompt = "Please generate tests for my code.",
    },
    Commit = {
      prompt = "Write commit message for the change with commitizen convention. Keep the title under 50 characters and wrap message at 72 characters. Format as a gitcommit code block.",
      context = "git:staged",
    },
  },
  mappings = {
    reset = {
      normal = "<C-r>",
      insert = "<C-r>",
    },
  },
}
