local M = {}

function M.setup()
	return {
		on_setup = function(server)
			server:setup({})
		end,
	}
end

return M
