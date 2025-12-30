---@private
---@class bar.key_table
local M = {}

-- Default key table name mappings
local default_mode_names = {
    copy = "COPY",
    search = "SEARCH",
    resize_pane = "RESIZE",
    activate_pane = "ACTIVATE",
}

---get current key table mode
---@param window any
---@return string|nil
local function get_key_table(window)
    return window:active_key_table()
end

---get key table status text
---@param window any
---@param options bar.options
---@return string
M.get_status = function(window, options)
    if not options.modules.key_table.enabled then
        return ""
    end

    local key_table = get_key_table(window)

    -- If no key table is active, return empty or show "NORMAL" based on config
    if not key_table then
        if options.modules.key_table.show_normal then
            return options.modules.key_table.normal_name or "NORMAL"
        end
        return ""
    end

    -- Remove _mode suffix if present
    local mode = key_table:gsub("_mode$", "")

    -- Merge default mappings with user-defined mappings
    local mode_names = {}
    for k, v in pairs(default_mode_names) do
        mode_names[k] = v
    end
    if options.modules.key_table.mode_names then
        for k, v in pairs(options.modules.key_table.mode_names) do
            mode_names[k] = v
        end
    end

    -- Return mapped name or uppercase the key table name
    return mode_names[mode] or mode:upper()
end

return M
