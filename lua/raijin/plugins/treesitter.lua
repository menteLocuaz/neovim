return {
	"menteLocuaz/nvim-treesitter-cus",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		vim.schedule(function()
			require("nvim-treesitter").setup({
				ensure_installed = {
					"json", "javascript", "typescript", "tsx", "yaml", "html", "css",
					"prisma", "markdown", "markdown_inline", "svelte", "graphql",
					"bash", "lua", "vim", "dockerfile", "gitignore", "query",
					"vimdoc", "c", "php", "go",
				},
				highlight = { enable = true },
				indent = { enable = true },
			})

			require("nvim-ts-autotag").setup()
		end)
	end,
}
