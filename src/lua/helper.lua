-- helper.lua --

-- Print contents of `tbl`, with indentation.
-- `indent` sets the initial level of indentation.
function tableToJson (tbl, indent)
    if not indent then
        indent = 1
    end
    local json = ""
    
    json = "{"
    local loopCounter = 0
    for k, v in pairs(tbl) do
        if loopCounter > 0 then
            json = json .. ",\n"
        else
            json = json .. "\n"
        end
        loopCounter = loopCounter + 1
        local formatting = string.rep("  ", indent)
        json = json .. formatting .. "\"" .. k .. "\": "
        if type(v) == "table" then
            json = json .. tprint(v, indent + 1) .. ""
        elseif type(v) == "boolean" then
            json = json .. tostring(v) .. ""
        elseif type(v) == "number" then
            json = json .. v .. ""
        elseif type(v) == "nil" then
            json = json .. "null" .. ""
        else
            json = json .. "\"" .. v .. "\""
        end
    end
    json = json .. "\n" .. string.rep("  ", indent - 1) .. "}"
    return json
end
