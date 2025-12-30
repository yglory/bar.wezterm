local utilities = require "bar.utilities"

---@private
---@class bar.leader
local M = {}

---get leader status text
---@param window any
---@param options bar.options
---@return string
M.get_status = function(window, options)
    if window:leader_is_active() then
        return options.modules.leader.icon .. utilities._space("leader", options.separator.space)
    end
    return ""
end

return M
