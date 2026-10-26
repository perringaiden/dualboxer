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

function DualBoxer:FastRegen(masterUnit, classID)
    local spellName = DualBoxer:GetFastRegenSpell(classID)

    if spellName ~= nil then
        return {
            ButtonFrameName = "FastRegen",
            Type = "spell",
            Spell = spellName,
            Unit = masterUnit
        }
    end
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

function DualBoxer:ButtonDetails_Buff(masterUnit, playerClassID)
    if playerClassID == 11 then
        return {
            ButtonFrameName = "Buff",
            Type = "macro",
            MacroText = "/cast [@player,modifier:alt][@" .. masterUnit .. "] Mark of the Wild",
            Texture = 136078
        }
    end
end
