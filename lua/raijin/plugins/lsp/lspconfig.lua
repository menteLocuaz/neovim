return {
	"neovim/nvim-lspconfig",
	event = "VeryLazy",

	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},

	config = function()
		local keymap = vim.keymap.set
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Diagnostic signs
		vim.fn.sign_define("DiagnosticSignError", {
			text = " ",
			texthl = "DiagnosticSignError",
		})

		vim.fn.sign_define("DiagnosticSignWarn", {
			text = " ",
			texthl = "DiagnosticSignWarn",
		})

		vim.fn.sign_define("DiagnosticSignHint", {
			text = "󰠠 ",
			texthl = "DiagnosticSignHint",
		})

		vim.fn.sign_define("DiagnosticSignInfo", {
			text = " ",
			texthl = "DiagnosticSignInfo",
		})

		local server_configs = {
			svelte = {
				on_attach = function(client)
					vim.api.nvim_create_autocmd("BufWritePost", {
						pattern = { "*.js", "*.ts" },
						callback = function(ctx)
							client.notify("$/onDidChangeTsOrJsFile", {
								uri = ctx.match,
							})
						end,
					})
				end,
			},

			graphql = {
				filetypes = {
					"graphql",
					"gql",
					"svelte",
					"typescriptreact",
					"javascriptreact",
				},
			},

			emmet_ls = {
				filetypes = {
					"html",
					"typescriptreact",
					"javascriptreact",
					"css",
					"sass",
					"scss",
					"less",
					"svelte",
				},
			},

			lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},
		}

		local servers = {
			"ts_ls",
			"html",
			"cssls",
			"tailwindcss",
			"svelte",
			"lua_ls",
			"graphql",
			"emmet_ls",
			"prismals",
			"pyright",
			"phpantom",
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
	end,
}
