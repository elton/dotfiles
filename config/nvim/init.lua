-- 快捷键映射
require("keybindings")
-- Packer 插件管理
require("plugins").setup()
-- 主题设置
require("colorscheme")
-- 插件配置
require("config.nvim-treesitter")
require("config.comment")
require("config.fidget")
require("config.gitsigns")
require("config.nvim-autopairs")
require("config.surround")
require("config.indent-blankline")
require("config.toggleterm")
require("config.nvim-colorizer")

-- 内置LSP
require("lsp.setup")
require("lsp.cmp")
require("lsp.ui")
require("lsp.null-ls")
