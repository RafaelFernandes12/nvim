local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local template_dir = vim.fn.expand("~/source/notes/templates")
local note_dir = vim.fn.expand("~/source/notes/src")
local tag_dir = vim.fn.expand("~/source/notes/tags")
return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    config = function()
      vim.fn["mkdp#util#install"]()
      vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", { noremap = true, silent = true })
    end,
  },
  -- {
  --   "MeanderingProgrammer/render-markdown.nvim",
  --   dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  --   ---@module 'render-markdown'
  --   ---@type render.md.UserConfig
  --   opts = {
  --     render_modes = { 'n', 'c', 't' },
  --     vim.keymap.set(
  --       "n",
  --       "<leader>md",
  --       "<cmd>RenderMarkdown toggle<CR>",
  --       { noremap = true, silent = true, desc = "Toggle markdown preview" }
  --     ),
  --   },
  -- },
  {

    "OXY2DEV/markview.nvim",
    lazy = false,

    -- Completion for `blink.cmp`
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function(_, opts)
      require("markview").setup(opts)
    end,
  },

  {
    vim.keymap.set("n", "<leader>mt", function()
      local tag_files = vim.fn.readdir(tag_dir)

      pickers.new({}, {
        prompt_title = "Tags",
        finder = finders.new_table {
          results = tag_files,
        },
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            if selection then
              local tag = selection[1]
              local link = string.format("[%-s](tags/%s)", tag, tag)
              vim.api.nvim_put({ link }, "c", true, true)
            end
          end)
          return true
        end,
      }):find()
    end, { noremap = true, silent = true, desc = "Insert markdown tag link" }),

    vim.keymap.set("n", "<leader>mn", function()
      -- Only include files (not directories) in the template list
      local templates = {}
      for _, name in ipairs(vim.fn.readdir(template_dir)) do
        local full_path = template_dir .. "/" .. name
        if vim.fn.filereadable(full_path) == 1 then
          table.insert(templates, name)
        end
      end
      if not templates or vim.tbl_isempty(templates) then
        vim.notify("No templates found in " .. template_dir, vim.log.levels.WARN)
        return
      end

      pickers.new({}, {
        prompt_title = "Select Note Template",
        finder = finders.new_table { results = templates },
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, _)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            if not selection then return end
            local template_file = template_dir .. "/" .. selection[1]
            vim.ui.input({ prompt = "New note filename: " }, function(input)
              if not input or input == "" then return end
              -- Ensure .md extension
              if not input:match("%.md$") then
                input = input .. ".md"
              end
              local note_path = note_dir .. "/" .. input
              -- Read template and replace {{date}} with current date
              local lines = {}
              local date = os.date("%Y-%m-%d")
              local title = input:gsub("%.md$", "")
              for line in io.lines(template_file) do
                line = line:gsub("{{date}}", date)
                line = line:gsub("{{title}}", title)
                table.insert(lines, line)
              end

              -- Prompt for URL (optional)
              vim.ui.input({ prompt = "Add a URL (optional): " }, function(url)
                if url and url ~= "" then
                  -- Extract last segment after final /
                  local name = url:match("([^/]+)/?$") or url
                  table.insert(lines, string.format("[%s](%s)", name, url))
                end

                -- Write new note (only once, after URL prompt)
                local fd = io.open(note_path, "w")
                if fd then
                  for _, l in ipairs(lines) do
                    fd:write(l .. "\n")
                  end
                  fd:close()
                  vim.cmd("edit " .. vim.fn.fnameescape(note_path))
                else
                  vim.notify("Could not create note: " .. note_path, vim.log.levels.ERROR)
                  return
                end

                -- After note creation, update only tags referenced in the note
                local note_name = input:gsub("%.md$", "")
                local link = string.format("[%s](../src/%s)", note_name, input)

                -- Read the new note and extract tags from the - **Tags:** line
                local tag_line
                for line in io.lines(note_path) do
                  if line:match("^%- %*%*Tags:%*%*") then
                    tag_line = line
                    break
                  end
                end

                if tag_line then
                  -- Collect unique tag filenames
                  local tag_set = {}
                  for tag in tag_line:gmatch("([%w_%-]+%.md)") do
                    tag_set[tag] = true
                  end
                  -- Write reference only once per tag file
                  for tag, _ in pairs(tag_set) do
                    local tag_path = tag_dir .. "/" .. tag
                    local tag_fd = io.open(tag_path, "a")
                    if tag_fd then
                      tag_fd:write(link .. "\n")
                      tag_fd:close()
                    else
                      vim.notify("Could not update tag: " .. tag_path, vim.log.levels.ERROR)
                    end
                  end
                else
                  vim.notify("No tag line found in note: " .. note_path, vim.log.levels.WARN)
                end
              end)
            end)
          end)
          return true
        end,
      }):find()
    end, { noremap = true, silent = true, desc = "Create new note from template" }),
    vim.keymap.set("n", "<leader>ml", function()
      vim.ui.input({ prompt = "Paste URL to insert as markdown link: " }, function(url)
        if not url or url == "" then return end
        local name = url:match("([^/]+)/?$") or url
        local link = string.format("[%s](%s)", name, url)
        vim.api.nvim_put({ link }, "c", true, true)
      end)
    end, { noremap = true, silent = true, desc = "Insert markdown link from URL" })
  }
}
