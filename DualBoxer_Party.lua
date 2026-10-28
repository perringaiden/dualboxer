function DualBoxer:AddInviter(rest)
    local inviter = DualBoxer:ExtractCharacterName(rest)

    if inviter ~= nil then
        if not Wolf_Utilities:SetContains(DualBoxer_Settings.ApprovedCharacters, inviter) then
            table.insert(DualBoxer_Settings.ApprovedCharacters, inviter)
            print("Added " .. inviter .. " to the approved list.")
        end
    end
end

function DualBoxer:ListInviters()
    print("Auto-Accept Invite From:")
    for index, value in ipairs(DualBoxer_Settings.ApprovedCharacters) do
        print(value)
    end
end

-- Local Functions

function DualBoxer:ExtractCharacterName(value)
    local params = Wolf_Utilities:SplitString(value)
    local name = nil

    if #params > 0 then
        if params[1] ~= nil then
            name = strupper(params[1]:sub(1, 1)) .. strlower(params[1]:sub(2, strlen(params[1])))
        end
    end

    return name
end

function DualBoxer:UpdateLootMethod()
    if UnitIsGroupLeader("player", 1) then
        local lootMethod = C_PartyInfo.GetLootMethod()

        if lootMethod ~= 0 then
            if DualBoxer:FindApprovedMemberUnit() ~= nil then
                C_PartyInfo.SetLootMethod(0)
            end
        end
    else
        print("Unable to determine loot method.")
    end
end

function DualBoxer:FindApprovedMemberUnit()
    for i = 1, 4 do
        local unit = "party" .. i

        if UnitExists(unit) and UnitIsConnected(unit) then
            local characterName = UnitName(unit)

            if Wolf_Utilities:SetContains(DualBoxer_Settings.ApprovedCharacters, characterName, true) then
                return unit
            end
        end
    end

    return nil
end

function DualBoxer:ClassIDIcon(classID)
    if classID == nil then
        return nil
    elseif classID == 1 then -- Warrior
        return 626008
    elseif classID == 2 then -- Paladin
        return 626003
    elseif classID == 3 then -- Hunter
        return 626000
    elseif classID == 4 then -- Rogue
        return 626005
    elseif classID == 5 then -- Priest
        return 626004
    elseif classID == 7 then -- Shaman
        return 626006
    elseif classID == 8 then -- Mage
        return 626001
    elseif classID == 9 then -- Warlock
        return 626007
    elseif classID == 11 then -- Druid
        return 625999
    else
        return nil
    end
end

function DualBoxer:ClassIDsWithPets(classID)
    --[[ 
1	Warrior	WARRIOR	
2	Paladin	PALADIN	
3	Hunter	HUNTER	
4	Rogue	ROGUE	
5	Priest	PRIEST	
6	Death Knight	DEATHKNIGHT	Added in 3.0.2
7	Shaman	SHAMAN	
8	Mage	MAGE	
9	Warlock	WARLOCK	
10	Monk	MONK	Added in 5.0.4
11	Druid	DRUID	
12	Demon Hunter	DEMONHUNTER	Added in 7.0.3
13	Evoker	EVOKER	Added in 10.0.0
 ]]
    return ((classID == 3) or (classID == 9)) or DualBoxer_Settings.Debug
end
