return {
  'mfussenegger/nvim-dap',
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    require("nvim-dap-virtual-text").setup({})
    _G.is_debugging = false
    local widgets = require("dap.ui.widgets")
    local dap = require("dap")

    dap.adapters["pwa-chrome"] = {
      type = "server",
      host = "localhost",
      port = 9222,
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
        args = { "9222" },
      }
    }

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      -- port = 8123,
      port = 9229,
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
        -- args = { "8123" },
        args = { "9229" },
      }
    }

    dap.adapters.codelldb = {
      type = 'server',
      -- host = 'localhost',
      port = "${port}",
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
        args = { "--port", "${port}" },
      },
    }

    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = "${fileDirname}/${fileBasenameNoExtension}",
        cwd = '${workspaceFolder}',
      },
    }

    dap.configurations.c = dap.configurations.cpp
    for _, language in ipairs { "typescript", "javascript", "typescriptreact" } do
      dap.configurations[language] = {
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Debug Next.js Client (Chrome)",
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          protocol = "inspector",
          sourceMaps = true,
          skipFiles = { "<node_internals>/**" },
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          runtimeExecutable = "node",
        },
        {
          name = "Debug TS (ts-node-dev)",
          type = "pwa-node",
          request = "launch",
          runtimeExecutable = "ts-node-dev",
          args = { "--inspect=9229", "--respawn", "--transpile-only", "-r", "tsconfig-paths/register", "${workspaceFolder}/src/server.ts" },
          cwd = "${workspaceFolder}",
          envFile = "${workspaceFolder}/.env.dev",
          skipFiles = { "<node_internals>/**" },
          sourceMaps = true
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to nest process",
          -- port = 3000,
          processId = function()
            local handle = io.popen("ps aux | grep nest")
            if not handle then
              print("Failed to run process search command.")
              return
            end
            local pid = handle:read("*l")
            handle:close()
            if pid then
              return tonumber(pid:match("%d+")) -- Extract the PID from the output
            else
              return require 'dap.utils'.pick_process
            end
          end,
          console = "integratedTerminal",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to tsx process",
          port = 9229,
          cwd = "${workspaceFolder}",
          outFiles = { "${workspaceFolder}/dist/**/*.js" },
          sourceMaps = true,
          skipFiles = { "<node_internals>/**" },
        }
      }
    end

    -- nvim-dap-ui setup
    local dapui = require("dapui")
    dapui.setup({
      layouts = {
        {
          elements = {
            { id = "scopes",  size = 0.5, },
            { id = "watches", size = 0.5 },
          },
          size = 60,
          position = "right",
        },
        -- {
        --   elements = {
        --     { id = "console", size = 1.0 },
        --   },
        --   position = "bottom",
        --   size = 10,
        -- }

      }
    })

    -- Open and close dapui automatically
    dap.listeners.after.event_initialized["dapui_config"] = function()
      -- dapui.close()
      _G.is_debugging = true
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      -- dapui.close()
      _G.is_debugging = false
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      -- dapui.close()
      _G.is_debugging = false
    end

    function _G.debug_status()
      return (_G.is_debugging and "🐞 DEBUGGING" or "")
    end

    -- -- Custom keymaps for nvim-dap
    -- Auto-attach to a running NestJS process

    -- vim.api.nvim_create_autocmd("FileType", {
    --   pattern = "http",
    --   callback = function()
    --     vim.keymap.set('n', '<leader>rs', function()
    --       vim.cmd("KulalaRun")
    --       if _G.is_debugging then
    --         vim.cmd("b#")
    --       end
    --     end, { buffer = true, desc = "Run HTTP request and return to code if debugging" })
    --   end
    -- })
    vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DiagnosticError', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '×', texthl = 'DiagnosticWarn', linehl = '', numhl = '' })

    vim.keymap.set('n', 'P', function() widgets.hover() end, { desc = "DAP Widgets Hover" })
    vim.keymap.set('n', '<F6>', function() widgets.preview() end, { desc = "DAP Widgets Preview" })
    vim.keymap.set('n', '<F2>', function() widgets.centered_float(widgets.frames) end,
      { desc = "DAP Widgets Frames" })
    vim.keymap.set('n', '<F3>', function() widgets.centered_float(widgets.scopes) end,
      { desc = "DAP Widgets Scopes" })

    vim.keymap.set('n', '<F1>', function() dap.toggle_breakpoint() end, { desc = "DAP Toggle Breakpoint" })
    -- vim.keymap.set('n', '<F2>', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
    --   { desc = "DAP Set Conditional Breakpoint" })
    -- vim.keymap.set('n', '<F3>', function() dap.repl.open() end, { desc = "DAP Open REPL" })
    vim.keymap.set('n', '<F4>', function() dap.restart() end, { desc = "DAP restart" })
    vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = "DAP Continue" })
    vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = "DAP Step Over" })
    vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = "DAP Step Into" })
    vim.keymap.set('n', '<F12>', function() dap.step_out() end, { desc = "DAP Step Out" })
  end,
}
