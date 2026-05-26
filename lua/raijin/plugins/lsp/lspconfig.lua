return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },

	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},

	config = function()
		vim.schedule(function()
			local servers = require("raijin.servers")
			local keymap = vim.keymap.set
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local server_configs = {
				graphql = {
					filetypes = {
						"graphql", "gql", "svelte", "typescriptreact", "javascriptreact",
					},
				},

				emmet_ls = {
					filetypes = {
						"html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte",
					},
				},

				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
						},
					},
				},

				phpantom = {
					cmd = { "phpantom_lsp" },
					filetypes = { "php" },
					root_markers = { "composer.json", ".git" },
				},
			}

			for _, name in ipairs(servers) do
				local cfg = server_configs[name] or {}
				vim.lsp.config(
					name,
					vim.tbl_deep_extend("force", {
						capabilities = capabilities,
					}, cfg)
				)
			end

			vim.lsp.enable(servers)

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(event)
					local bufnr = event.buf
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if not client then
						return
					end

					if client.name == "svelte" and not vim.g._raijin_svelte_notify then
						vim.g._raijin_svelte_notify = true
						vim.api.nvim_create_autocmd("BufWritePost", {
							pattern = { "*.js", "*.ts" },
							callback = function(ctx)
								for _, cl in ipairs(vim.lsp.get_clients({ name = "svelte" })) do
									cl.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
								end
							end,
						})
					end

					local function map(mode, lhs, rhs, desc)
						keymap(mode, lhs, rhs, {
							buffer = bufnr,
							silent = true,
							desc = desc,
						})
					end

					map("n", "K", vim.lsp.buf.hover, "Hover")
					map("n", "gd", vim.lsp.buf.definition, "Definition")
					map("n", "gD", vim.lsp.buf.declaration, "Declaration")
					map("n", "gi", vim.lsp.buf.implementation, "Implementation")
					map("n", "gr", vim.lsp.buf.references, "References")
					map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
					map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
					map("n", "<leader>d", vim.diagnostic.open_float, "Line Diagnostics")
					map("n", "[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
					map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
				end,
			})
		end)
	end,
}
