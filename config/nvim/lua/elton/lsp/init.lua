local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("elton.lsp.lsp-installer")
require("elton.lsp.handlers").setup()
-- require("elton.lsp.null-ls")
-- require("elton.lsp.lsp-utils")
