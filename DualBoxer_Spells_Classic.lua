---@diagnostic disable: duplicate-set-field
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
function DualBoxer:ButtonDetails_FastRegen(masterUnit, classID)
    local spellID = DualBoxer:DruidFastRegenSpellID()

    if spellID ~= nil then
        return {
            ButtonFrameName = "FastRegen",
            Type = "spell",
            Spell = spellID,
            Unit = masterUnit
        }
    end
end

function DualBoxer:ButtonDetails_Assist(masterUnit, playerClassID, playerLevel)
    if playerClassID == 11 then
        return {
            ButtonFrameName = "Assist",
            Type = "spell",
            Spell = "Wrath",
            Unit = masterUnit .. "target"
        }
    end
end

function DualBoxer:ButtonDetails_RegularHeal(masterUnit, playerClassID)
    if playerClassID == 11 then
        return {
            ButtonFrameName = "RegularHeal",
            Type = "spell",
            Spell = "Regrowth",
            Unit = masterUnit
        }
    end
end

function DualBoxer:ButtonDetails_PrimaryHeal(masterUnit, playerClassID)
    if playerClassID == 11 then
        return {
            ButtonFrameName = "PrimaryHeal",
            Type = "spell",
            Spell = "Healing Touch",
            Unit = masterUnit
        }
    end
end

function DualBoxer:ButtonDetails_Regen(masterUnit, playerClassID)

end

function DualBoxer:ButtonDetails_LightDirect(masterUnit, playerClassID)

end

function DualBoxer:ButtonDetails_Follow(masterUnit, classID)
    local followTemplate = [[/follow %s
/cast [@%s] %s]]

    return {
        ButtonFrameName = "Follow",
        Type = "macro",
        MacroText = string.format(followTemplate, masterUnit, masterUnit, DualBoxer:GetFastRegenSpell(classID)),
        Texture = DualBoxer:ClassIDIcon(classID)
    }
end

function DualBoxer:ButtonDetails_PartyHeal(masterUnit, playerClassID)

end

function DualBoxer:ButtonDetails_ClearDebuff(masterUnit, playerClassID)

end

function DualBoxer:ButtonDetails_BuffTwo(masterUnit, playerClassID)

end

function DualBoxer:ButtonDetails_Buff(masterUnit, playerClassID)
    if playerClassID == 11 then
        return {
            ButtonFrameName = "Buff",
            Type = "spell",
            Spell = "Mark of the Wild",
            Unit = masterUnit,
            AllUnits = true
        }
    end
end

function DualBoxer:ButtonDetails_Mount(playerClassID)

end

function DualBoxer:ButtonDetails_SelfRegularHeal(playerClassID)

end

function DualBoxer:ButtonDetails_SelfPrimaryHeal(playerClassID)

end

function DualBoxer:ButtonDetails_SelfRegen(playerClassID)

end

function DualBoxer:ButtonDetails_SelfLight(playerClassID)

end

function DualBoxer:ButtonDetails_ManaSpecial(masterUnit, playerClassID)

end

function DualBoxer:ButtonDetails_PetRegularHeal(masterUnit, playerClassID)

end

function DualBoxer:ButtonDetails_PetHeal(masterUnit, playerClassID)

end

function DualBoxer:ButtonDetails_PetRegen(masterUnit, playerClassID)

end

function DualBoxer:ButtonDetails_PetLightHeal(masterUnit, playerClassID)

end

function DualBoxer:GetFastRegenSpell(classID)
    if classID == 2 then
        return "Flash Heal"
    elseif classID == 5 then
        return "Renew"
    elseif classID == 7 then
        return "Healing Wave"
    elseif classID == 11 then
        return "Rejuvenation"
    end

    return nil
end
