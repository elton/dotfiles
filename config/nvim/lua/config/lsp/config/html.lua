local M = {}

function M.setup()
	return {
		on_setup = function(server)
			server:setup({
				capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
				flags = {
					debounce_text_changes = 150,
				},
				on_attach = function(client, bufnr)
					-- 禁用格式化功能，交给专门插件插件处理
					client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
					local function buf_set_keymap(...)
						vim.api.nvim_buf_set_keymap(bufnr, ...)
					end
					-- 绑定快捷键
					require("keybindings").mapLSP(buf_set_keymap)
				end,
			})
		end,
	}
end

return M
