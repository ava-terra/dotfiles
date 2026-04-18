-- lua/codecompanion-workflows.lua
-- Model selection workflow based on task complexity

local M = {}

-- Model definitions with their complexity tier and costs
local MODELS = {
  -- Budget tier (0.33x) - Quick tasks
  haiku = {
    name = "claude-3-5-haiku-20241022",
    display = "Haiku (Budget)",
    multiplier = 0.33,
    tier = "budget",
    description = "Fast & cheap - ideal for quick explanations, simple refactors, syntax fixes",
  },
  -- Standard tier (1x) - Most tasks
  sonnet = {
    name = "claude-3-5-sonnet-20241022",
    display = "Sonnet (Standard)",
    multiplier = 1,
    tier = "standard",
    description = "Balanced - ideal for code generation, refactoring, debugging",
  },
  -- Premium tier (3x) - Complex reasoning
  opus = {
    name = "claude-3-5-opus-20241022",
    display = "Opus (Premium)",
    multiplier = 3,
    tier = "premium",
    description = "Powerful - ideal for architecture, multi-file changes, complex logic",
  },
  -- Included (0x) - Free on paid plans
  gpt5_mini = {
    name = "gpt-5-mini",
    display = "GPT-5 Mini (Free)",
    multiplier = 0,
    tier = "free",
    description = "Fast & free on paid plans - good for general tasks",
  },
}

-- Task complexity definitions
local TASKS = {
  -- Simple tasks -> use Haiku
  explain = {
    name = "Explain Code",
    complexity = "simple",
    recommended_model = "haiku",
  },
  fix_syntax = {
    name = "Fix Syntax",
    complexity = "simple",
    recommended_model = "haiku",
  },
  -- Medium tasks -> use Sonnet
  refactor = {
    name = "Refactor Code",
    complexity = "medium",
    recommended_model = "sonnet",
  },
  debug = {
    name = "Debug Issue",
    complexity = "medium",
    recommended_model = "sonnet",
  },
  generate = {
    name = "Generate Code",
    complexity = "medium",
    recommended_model = "sonnet",
  },
  -- Complex tasks -> use Opus
  architect = {
    name = "Architecture Design",
    complexity = "complex",
    recommended_model = "opus",
  },
  multi_file = {
    name = "Multi-File Refactor",
    complexity = "complex",
    recommended_model = "opus",
  },
  reasoning = {
    name = "Complex Reasoning",
    complexity = "complex",
    recommended_model = "opus",
  },
}

---Get recommended model for a task
---@param task_name string
---@return table|nil
function M.get_recommended_model(task_name)
  local task = TASKS[task_name]
  if task then
    return MODELS[task.recommended_model]
  end
  return nil
end

---Get all available models
---@return table
function M.get_models()
  return MODELS
end

---Get model by name
---@param model_key string
---@return table|nil
function M.get_model(model_key)
  return MODELS[model_key]
end

---Get tasks by complexity
---@param complexity string
---@return table
function M.get_tasks_by_complexity(complexity)
  local result = {}
  for key, task in pairs(TASKS) do
    if task.complexity == complexity then
      table.insert(result, { key = key, task = task })
    end
  end
  return result
end

---Create a model selection picker
---@param callback fun(model: table, model_key: string)
function M.show_model_picker(callback)
  local models = M.get_models()
  local choices = {}

  -- Order by tier: free, budget, standard, premium
  local tier_order = { free = 1, budget = 2, standard = 3, premium = 4 }
  local model_list = {}
  for key, model in pairs(models) do
    table.insert(model_list, { key = key, model = model })
  end
  table.sort(model_list, function(a, b)
    return tier_order[a.model.tier] < tier_order[b.model.tier]
  end)

  for _, entry in ipairs(model_list) do
    local key = entry.key
    local model = entry.model
    table.insert(choices, string.format("%s - %s", model.display, model.description))
  end

  vim.ui.select(choices, { prompt = "Select Model:" }, function(choice, idx)
    if choice then
      local selected = model_list[idx]
      callback(selected.model, selected.key)
    end
  end)
end

---Create a task picker for quick model selection
---@param callback fun(model: table, task: table)
function M.show_task_picker(callback)
  local complexity_levels = { "simple", "medium", "complex" }
  local complexity_labels = {
    simple = "Simple (Haiku/Fast)",
    medium = "Medium (Sonnet/Balanced)",
    complex = "Complex (Opus/Powerful)",
  }

  vim.ui.select(complexity_levels, {
    prompt = "Select Task Complexity:",
    format_item = function(item)
      return complexity_labels[item]
    end,
  }, function(choice)
    if choice then
      local tasks = M.get_tasks_by_complexity(choice)
      local task_names = {}
      for _, entry in ipairs(tasks) do
        table.insert(task_names, entry.task.name)
      end

      vim.ui.select(task_names, { prompt = "Select Task:" }, function(task_choice, task_idx)
        if task_choice then
          local selected_task = tasks[task_idx]
          local model = M.get_recommended_model(selected_task.key)
          callback(model, selected_task.task)
        end
      end)
    end
  end)
end

---Set the current model in CodeCompanion
---@param model_name string
function M.set_model(model_name)
  local model = M.get_model(model_name)
  if not model then
    vim.notify(string.format("Model %s not found", model_name), vim.log.levels.ERROR)
    return
  end

  vim.notify(string.format("Switching to %s...", model.display), vim.log.levels.INFO)
end

return M
