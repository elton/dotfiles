local M = {}

function M.setup()
	return {
		on_setup = function(server)
			server:setup({
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
					},
				},
				capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
				flags = {
					debounce_text_changes = 150,
				},
				on_attach = function(client, _)
					-- 禁用格式化功能，交给专门插件插件处理
					client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
				end,
			})
		end,
	}
end

return M
