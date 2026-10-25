Utilities = {}

-- SetContains
-- Description: Returns True if the provided set contains the value.
-- Parameters:
-- set - The set to check.
-- value - The value to check for.
function Utilities:SetContains(set, value, caseInsensitive)
    if set ~= nil then
        for i, entry in ipairs(set) do
            if caseInsensitive == true then
                if Utilities:CaseInsensitiveEquals(entry, value) then
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
function Utilities:SplitString(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

function Utilities:CaseInsensitiveEquals(valueA, valueB)
    return strlower(valueA) == strlower(valueB)
end

function Utilities:InsertInTable(tableObj, value)
    if value ~= nil then
        table.insert(tableObj, value)
    end
end

function Utilities:TableToString(tableObj)
    local result = "{"

    for i, value in ipairs(tableObj) do
        result = result .. i .. ": " .. value .. ", "
    end
    result = result .. "}"
    return result
end
