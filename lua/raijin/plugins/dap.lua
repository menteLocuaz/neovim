return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        config = function()
          local dapui = require("dapui")
          dapui.setup()
          local dap = require("dap")
          dap.listeners.after.event_initialized["dapui_config"] = dapui.open
          dap.listeners.after.event_terminated["dapui_config"] = dapui.close
          dap.listeners.after.event_exited["dapui_config"] = dapui.close
        end,
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
      {
        "mfussenegger/nvim-dap-python",
        config = function()
          require("dap-python").setup("python3")
        end,
      },
    },
    config = function()
      local dap = require("dap")

      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue / Start" })
      vim.keymap.set("n", "<leader>dso", dap.step_over, { desc = "Step over" })
      vim.keymap.set("n", "<leader>dsi", dap.step_into, { desc = "Step into" })
      vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
      vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate" })
      vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle REPL" })
    end,
  },
}
