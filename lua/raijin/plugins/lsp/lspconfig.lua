return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local keymap = vim.keymap
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    for type, icon in pairs({ Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }) do
      vim.fn.sign_define("DiagnosticSign" .. type, { text = icon, texthl = "DiagnosticSign" .. type, numhl = "" })
    end

    for _, name in ipairs(require("mason-lspconfig").get_installed_servers()) do
      if not pcall(vim.lsp.config, name) then
        goto continue
      end
      local opts = { capabilities = capabilities }
      if name == "svelte" then
        opts.on_attach = function(client)
          vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.js", "*.ts" },
            callback = function(ctx)
              client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
            end,
          })
        end
      elseif name == "graphql" then
        opts.filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" }
      elseif name == "emmet_ls" then
        opts.filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" }
      elseif name == "lua_ls" then
        opts.settings = { Lua = { diagnostics = { globals = { "vim" } }, completion = { callSnippet = "Replace" } } }
      end
      vim.lsp.config(name, opts)
      ::continue::
    end
    vim.lsp.enable()

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local o = { buffer = ev.buf, silent = true }
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", { desc = "Show LSP references", buffer = ev.buf, silent = true })
        keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = ev.buf, silent = true })
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Show LSP definitions", buffer = ev.buf, silent = true })
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "Show LSP implementations", buffer = ev.buf, silent = true })
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Show LSP type definitions", buffer = ev.buf, silent = true })
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "See available code actions", buffer = ev.buf, silent = true })
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename", buffer = ev.buf, silent = true })
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show buffer diagnostics", buffer = ev.buf, silent = true })
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics", buffer = ev.buf, silent = true })
        keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic", buffer = ev.buf, silent = true })
        keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic", buffer = ev.buf, silent = true })
        keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation for what is under cursor", buffer = ev.buf, silent = true })
        keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", { desc = "Restart LSP", buffer = ev.buf, silent = true })
      end,
    })
  end,
}