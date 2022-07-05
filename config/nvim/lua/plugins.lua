local M = {}

function M.setup()
	local paccker_bootstrap

	local function packer_init()
		local fn = vim.fn
		-- 自动安装 Packer.nvim
		-- 插件安装目录
		-- ~/.local/share/nvim/site/pack/packer/start
		local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

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
			vim.cmd([[packadd packer.nvim]])

			-- https://github.com/wbthomason/packer.nvim/issues/750
			local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
			if not string.find(vim.o.runtimepath, rtp_addition) then
				vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
			end
			vim.notify("Pakcer.nvim 安装完毕")
		end
		vim.cmd("autocmd BufWritePost plugins.lua source <afile> | PackerCompile")
	end

	-- packer.nvim configuration
	local conf = {
		profile = {
			enable = true,
			threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
		},
		compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
		-- 并发数限制
		max_jobs = 16,
		-- 以浮动窗口打开安装列表
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
		},
	}

	local function plugins(use)
		-- Performence
		use("lewis6991/impatient.nvim")
		-- Packer 可以管理自己本身
		use("wbthomason/packer.nvim")

		--------------------- colorschemes --------------------
		-- nord
		use({
			"shaunsingh/nord.nvim",
			config = function()
				vim.cmd([[colorscheme nord]])
			end,
		})

		--------------------- plugins -------------------------
		-- WhichKey
		use({
			"folke/which-key.nvim",
			event = "VimEnter",
			config = function()
				require("config.whichkey").setup()
			end,
		})
		-- nvim-tree
		use({
			"kyazdani42/nvim-tree.lua",
			requires = "kyazdani42/nvim-web-devicons",
			event = "BufWinEnter",
			config = function()
				require("nvim-tree").setup()
			end,
		})
		-- bufferline
		use({
			"akinsho/bufferline.nvim",
			requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" },
			event = "BufReadPre",
			config = function()
				require("config.bufferline").setup()
			end,
		})

		use({
			"SmiteshP/nvim-gps",
			module = "nvim-gps",
			config = function()
				require("nvim-gps").setup()
			end,
		})
		-- lualine
		use({
			"nvim-lualine/lualine.nvim",
			after = "nvim-treesitter",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = function()
				require("config.lualine").setup()
			end,
		})
		-- telescope
		use("nvim-lua/popup.nvim")
		use({
			"nvim-telescope/telescope.nvim",
			module = "telescope",
			as = "telescope",
			requires = {
				"nvim-lua/plenary.nvim",
				"LinArcX/telescope-env.nvim",
				"nvim-telescope/telescope-ui-select.nvim",
				"nvim-telescope/telescope-media-files.nvim",
			},
			config = function()
				require("config.telescope").setup()
			end,
		})
		-- dashboard-nvim
		-- use("glepnir/dashboard-nvim")
		-- alpha-nvim
		use({
			"goolord/alpha-nvim",
			config = function()
				require("config.alpha").setup()
			end,
		})

		-- project
		use({
			"ahmedkhalf/project.nvim",
			event = "VimEnter",
			config = function()
				require("config.project").setup()
			end,
		})
		-- treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			as = "nvim-treesitter",
			event = "BufRead",
			opt = true,
			run = ":TSUpdate",
			config = function()
				require("config.treesitter").setup()
			end,
		})
		use("p00f/nvim-ts-rainbow")
		-- indent-blankline
		use({
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("config.indent-blankline")
			end,
		})
		-- show color
		use({
			"norcalli/nvim-colorizer.lua",
			cmd = "ColorizerToggle",
			config = function()
				require("colorizer").setup()
			end,
		})
		-- wakatime
		use("wakatime/vim-wakatime")
		-- Copilot
		use("github/copilot.vim")
		--------------------- LSP --------------------
		use({ "williamboman/nvim-lsp-installer" })
		-- Lspconfig
		use({
			"neovim/nvim-lspconfig",
			as = "nvim-lspconfig",
			after = "nvim-treesitter",
			opt = true,
			config = function()
				require("config.lsp").setup()
				-- require("config.dap").setup()
			end,
		})
		use({ "ray-x/lsp_signature.nvim" })

		use({
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			opt = true,
			requires = {
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-nvim-lsp",
				-- {
				-- 	"quangnguyen30192/cmp-nvim-ultisnips",
				-- 	config = function()
				-- 		-- optional call to setup (see customization section)
				-- 		require("cmp_nvim_ultisnips").setup({})
				-- 	end,
				-- 	-- If you want to enable filetype detection based on treesitter:
				-- 	-- requires = { "nvim-treesitter/nvim-treesitter" },
				-- },
				"hrsh7th/vim-vsnip",
				"hrsh7th/cmp-nvim-lua",
				"octaltree/cmp-look",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-calc",
				"f3fora/cmp-spell",
				"hrsh7th/cmp-emoji",
				"ray-x/cmp-treesitter",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-nvim-lsp-document-symbol",
			},
			config = function()
				require("config.cmp").setup()
			end,
		})

		-- 常见编程语言代码段
		use("rafamadriz/friendly-snippets")
		-- ui
		use({
			"onsails/lspkind-nvim",
			config = function()
				require("lspkind").init()
			end,
		})
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
		use({ "tpope/vim-surround", event = "BufRead" })
		-- Comment
		use({
			"numToStr/Comment.nvim",
			keys = { "gc", "gcc", "gbc" },
			config = function()
				require("config.comment").setup()
			end,
		})
		-- nvim-autopairs
		use({
			"windwp/nvim-autopairs",
			run = "make",
			config = function()
				require("nvim-autopairs").setup({})
			end,
		})
		-- git
		use({
			"TimUntersberger/neogit",
			cmd = "Neogit",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("config.neogit").setup()
			end,
		})
		use({
			"lewis6991/gitsigns.nvim",
			config = function()
				require("config.gitsigns").setup()
			end,
		})
		use({
			"sindrets/diffview.nvim",
			cmd = {
				"DiffviewOpen",
				"DiffviewClose",
				"DiffviewToggleFiles",
				"DiffviewFocusFiles",
			},
		})
		-- vimspector
		use("puremourning/vimspector")
		----------------------------------------------
		use("mfussenegger/nvim-dap")
		use("theHamsta/nvim-dap-virtual-text")
		use("rcarriga/nvim-dap-ui")
		-- use("Pocco81/DAPInstall.nvim")
		-- use("jbyuki/one-small-step-for-vimkind")

		use({
			"j-hui/fidget.nvim",
			event = "BufReadPre",
			config = function()
				require("fidget").setup({})
			end,
		})
		if paccker_bootstrap then
			print("Setting up Neovim. Restart required after installation!")
			require("packer").sync()
		end
	end

	packer_init()

	-- Use a protected call so we don't error out on first use
	local status_ok, packer = pcall(require, "packer")
	if not status_ok then
		vim.notify("没有安装 packer.nvim")
		return
	end

	pcall(require, "impatient")
	pcall(require, "packer_compiled")
	packer.init(conf)
	packer.startup(plugins)
end

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

return M
