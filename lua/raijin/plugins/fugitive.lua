return {
	"tpope/vim-fugitive",

	cmd = {
		"G",
		"Git",
	},

	keys = {
		{
			"<leader>ga",
			"<cmd>Git fetch --all -p<cr>",
			desc = "Git Fetch All",
		},

		{
			"<leader>gl",
			"<cmd>Git pull<cr>",
			desc = "Git Pull",
		},
		{
			"<leader>gs",
			"<cmd>Git<cr>",
			desc = "Git Status",
		},

		{
			"<leader>gc",
			"<cmd>Git commit<cr>",
			desc = "Git Commit",
		},

		{
			"<leader>gp",
			"<cmd>Git push<cr>",
			desc = "Git Push",
		},

		{
			"<leader>gd",
			"<cmd>Gdiffsplit<cr>",
			desc = "Git Diff",
		},

		{
			"<leader>gb",
			"<cmd>Git blame<cr>",
			desc = "Git Blame",
		},
	},
}
