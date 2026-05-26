return {
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				compile = true,
				undercurl = true,
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = true },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = false,
				dimInactive = false,
				terminalColors = true,
				colors = {
					palette = {},
					theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
				},
				overrides = function(colors)
					return {}
				end,
				theme = "lotus",
				background = {
					dark = "wave",
					light = "lotus",
				},
			})
			vim.cmd("colorscheme kanagawa")
		end,
	},
}
