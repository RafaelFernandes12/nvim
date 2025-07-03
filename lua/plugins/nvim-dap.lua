return {
  'mfussenegger/nvim-dap',
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    require("nvim-dap-virtual-text").setup({})

    local widgets = require("dap.ui.widgets")
    local dap = require("dap")

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = 8123,
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
        args = { "8123" },
      }
    }

    for _, language in ipairs { "typescript", "javascript" } do
      dap.configurations[language] = {
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
          type = "pwa-node",
          request = "attach",
          name = "Attach to process",
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
              return require 'dap.utils'.pick_process()
            end
          end,
          console = "integratedTerminal",
          cwd = "${workspaceFolder}",
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
    -- dap.listeners.after.event_initialized["dapui_config"] = function()
    --   dapui.open()
    -- end
    -- dap.listeners.before.event_terminated["dapui_config"] = function()
    --   dapui.close()
    -- end
    -- dap.listeners.before.event_exited["dapui_config"] = function()
    --   dapui.close()
    -- end


    -- -- Custom keymaps for nvim-dap
    -- Auto-attach to a running NestJS process

    vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DiagnosticError', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '×', texthl = 'DiagnosticWarn', linehl = '', numhl = '' })

    vim.keymap.set('n', 'P', function() widgets.hover() end, { desc = "DAP Widgets Hover" })
    vim.keymap.set('n', '<Leader>bp', function() widgets.preview() end, { desc = "DAP Widgets Preview" })
    vim.keymap.set('n', '<Leader>bf', function() widgets.centered_float(widgets.frames) end,
      { desc = "DAP Widgets Frames" })
    vim.keymap.set('n', '<Leader>bs', function() widgets.centered_float(widgets.scopes) end,
      { desc = "DAP Widgets Scopes" })

    vim.keymap.set('n', '<F1>', function() dap.toggle_breakpoint() end, { desc = "DAP Toggle Breakpoint" })
    vim.keymap.set('n', '<F2>', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
      { desc = "DAP Set Conditional Breakpoint" })
    vim.keymap.set('n', '<F3>', function() dap.repl.open() end, { desc = "DAP Open REPL" })
    vim.keymap.set('n', '<F4>', function() dap.run_last() end, { desc = "DAP Run Last" })
    vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = "DAP Continue" })
    vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = "DAP Step Over" })
    vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = "DAP Step Into" })
    vim.keymap.set('n', '<F12>', function() dap.step_out() end, { desc = "DAP Step Out" })
  end,
}
