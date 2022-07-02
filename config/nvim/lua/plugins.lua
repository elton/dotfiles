-- 自动安装 Packer.nvim
-- 插件安装目录
-- ~/.local/share/nvim/site/pack/packer/
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local paccker_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
	vim.notify("正在安装Pakcer.nvim，请稍后...")
	paccker_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		-- "https://gitcode.net/mirrors/wbthomason/packer.nvim",
		install_path,
	})

	-- https://github.com/wbthomason/packer.nvim/issues/750
	local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
	if not string.find(vim.o.runtimepath, rtp_addition) then
		vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
	end
	vim.notify("Pakcer.nvim 安装完毕")
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	vim.notify("没有安装 packer.nvim")
	return
end

packer.startup({
	function(use)
		-- Packer 可以管理自己本身
		use("wbthomason/packer.nvim")
		--------------------- colorschemes --------------------
		-- tokyonight
		use("folke/tokyonight.nvim")
		-- nord
		use("shaunsingh/nord.nvim")
		-- nightfox
		use("EdenEast/nightfox.nvim")

		--------------------- plugins -------------------------
		-- nvim-tree
		use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
		-- bufferline
		use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" } })
		-- lualine
		use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
		use("arkav/lualine-lsp-progress")
		-- telescope
		use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
		-- telescope extensions
		use("LinArcX/telescope-env.nvim")
		use("nvim-telescope/telescope-ui-select.nvim")
		-- dashboard-nvim
		use("glepnir/dashboard-nvim")
		-- project
		use("ahmedkhalf/project.nvim")
		-- treesitter
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
		use("p00f/nvim-ts-rainbow")
		-- indent-blankline
		use("lukas-reineke/indent-blankline.nvim")
		-- show color
		use("norcalli/nvim-colorizer.lua")
		-- wakatime
		use("wakatime/vim-wakatime")
		-- Copilot
		use("github/copilot.vim")
		--------------------- LSP --------------------
		use({ "williamboman/nvim-lsp-installer" })
		-- Lspconfig
		use({ "neovim/nvim-lspconfig" })

		-- 补全引擎
		use("hrsh7th/nvim-cmp")
		-- snippet 引擎
		use("hrsh7th/vim-vsnip")
		-- 补全源
		use("hrsh7th/cmp-vsnip")
		use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
		use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
		use("hrsh7th/cmp-path") -- { name = 'path' }
		use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }
		use("hrsh7th/cmp-nvim-lsp-signature-help") -- { name = 'nvim_lsp_signature_help' }

		-- 常见编程语言代码段
		use("rafamadriz/friendly-snippets")
		-- ui
		use("onsails/lspkind-nvim")
		use("tami5/lspsaga.nvim")
		-- 代码格式化
		use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })
		-- JSON 增强
		use("b0o/schemastore.nvim")
		-- TypeScript
		use({ "jose-elias-alvarez/nvim-lsp-ts-utils", requires = "nvim-lua/plenary.nvim" })
		-- Lua 增强
		use("folke/lua-dev.nvim")
		-- Rust 增强
		use("simrat39/rust-tools.nvim")
		-------------------------------------------------------
		use({ "akinsho/toggleterm.nvim" })
		-- surround
		use("ur4ltz/surround.nvim")
		-- Comment
		use("numToStr/Comment.nvim")
		-- nvim-autopairs
		use("windwp/nvim-autopairs")
		-- git
		use({ "lewis6991/gitsigns.nvim" })
		use({ "sindrets/diffview.nvim" })
		-- vimspector
		use("puremourning/vimspector")
		----------------------------------------------
		use("mfussenegger/nvim-dap")
		use("theHamsta/nvim-dap-virtual-text")
		use("rcarriga/nvim-dap-ui")
		-- use("Pocco81/DAPInstall.nvim")
		-- use("jbyuki/one-small-step-for-vimkind")

		use("j-hui/fidget.nvim")
		if paccker_bootstrap then
			packer.sync()
		end
	end,
	config = {
		-- 并发数限制
		max_jobs = 16,
		-- 自定义源
		git = {
			-- default_url_format = "https://hub.fastgit.xyz/%s",
			-- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
			-- default_url_format = "https://gitcode.net/mirrors/%s",
			-- default_url_format = "https://gitclone.com/github.com/%s",
		},
		-- 以浮动窗口打开安装列表
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
		},
	},
})

-- 每次保存 plugins.lua 自动安装插件
-- pcall(
-- 	vim.cmd,
-- 	[[
--     augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--     augroup end
--   ]]
-- )
