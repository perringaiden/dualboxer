function DualBoxer:DruidFastRegenSpellID()
    for i, spellID in pairs({25299, 9841, 9840, 9839, 8910, 3627, 2091, 2090, 1430, 1058, 774}) do
        if IsSpellKnown(spellID) then
            return spellID
        end
    end

    return nil
end
