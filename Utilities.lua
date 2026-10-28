---@diagnostic disable-next-line: create-global
Wolf_Utilities = {}

-- SetContains
-- Description: Returns True if the provided set contains the value.
-- Parameters:
-- set - The set to check.
-- value - The value to check for.
function Wolf_Utilities:SetContains(set, value, caseInsensitive)
    if set ~= nil then
        for i, entry in ipairs(set) do
            if caseInsensitive == true then
                if Wolf_Utilities:CaseInsensitiveEquals(entry, value) then
                    return true
                end
            else
                if entry == value then
                    return true
                end
            end
        end
    end

    return false
end

-- SplitString
-- Description: Returns an array of strings split by the separator.
-- Parameters:
-- inputstr - The input string.
-- sep - The separator character.
function Wolf_Utilities:SplitString(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

function Wolf_Utilities:CaseInsensitiveEquals(valueA, valueB)
    return strlower(valueA) == strlower(valueB)
end

function Wolf_Utilities:InsertInTable(tableObj, value)
    if value ~= nil then
        table.insert(tableObj, value)
    end
end

function Wolf_Utilities:TableToString(tableObj)
    local result = "{"

    for i, value in ipairs(tableObj) do
        result = result .. i .. ": " .. value .. ", "
    end
    result = result .. "}"
    return result
end

function Wolf_Utilities:CallFunctionIfExists(func, fallback, ...)
    if func ~= nil then
        return func(...)
    end
    if fallback ~= nil then
        return fallback(...)
    end
end
