-- see the "LazyVim/LazyVim" entry below for how to change a default option.
return {
	-- Match the terminal's Dracula theme inside Neovim too.
	{ "Mofiqul/dracula.nvim" },
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "dracula",
		},
	},
}
