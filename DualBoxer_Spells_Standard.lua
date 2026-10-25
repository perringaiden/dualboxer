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
function DualBoxer:DoNothing()
    -- Do nothing.
end

function DualBoxer:ButtonDetails_FastRegen(masterUnit, playerClassID, playerLevel)
    if playerClassID == 2 then
    elseif playerClassID == 10 then
        return {
            ButtonFrameName = "FastRegen",
            Type = "spell",
            Spell = "Soothing Mist",
            Unit = masterUnit
        }
    elseif playerClassID == 11 then
        return {
            ButtonFrameName = "FastRegen",
            Type = "spell",
            Spell = "Lifebloom",
            Unit = masterUnit
        }
    end
end

function DualBoxer:ButtonDetails_Assist(masterUnit, playerClassID, playerLevel)
    if playerClassID == 10 then
        return {
            ButtonFrameName = "Assist",
            Type = "spell",
            Spell = "Crackling Jade Lightning",
            Unit = masterUnit .. "target"
        }
    elseif playerClassID == 11 then
        return {
            ButtonFrameName = "Assist",
            Type = "spell",
            Spell = "Wrath",
            Unit = masterUnit .. "target"
        }
    end
end

function DualBoxer:ButtonDetails_PrimaryHeal(masterUnit, playerClassID)
    if playerClassID == 10 then
        -- return {
        --     ButtonFrameName = "PrimaryHeal",
        --     Type = "spell",
        --     Spell = "Soothing Mist",
        --     Unit = masterUnit
        -- }
    elseif playerClassID == 11 then
        if DualBoxer.IsClassic then
            return {
                ButtonFrameName = "PrimaryHeal",
                Type = "spell",
                Spell = "Healing Touch",
                Unit = masterUnit
            }
        else
            return {
                ButtonFrameName = "PrimaryHeal",
                Type = "spell",
                Spell = "Nourish",
                Unit = masterUnit
            }
        end
    end
end

function DualBoxer:ButtonDetails_Mount(playerClassID)
    if playerClassID == 11 then
        if DualBoxer.IsClassic then
            return {
                ButtonFrameName = "Mount",
                Type = "macro",
                MacroText = [[
#showtooltip Swift Flight Form
/cast [flyable,nomod, noswimming] Swift Flight Form
/cast [swimming, nomod] Abyssal Seahorse
/cast [noflyable,nomod, noswimming][flyable,mod:alt] Winterspring Frostsaber
/dismount [mounted]
]]
            }
        else
            return {
                ButtonFrameName = "Mount",
                Type = "spell",
                Spell = "Travel Form"
            }
        end
    else
        return {
            ButtonFrameName = "Mount",
            Type = "spell",
            Spell = "Red Flying Cloud"
        }
    end
end

function DualBoxer:ButtonDetails_RegularHeal(masterUnit, playerClassID)
    if playerClassID == 10 then
        return {
            ButtonFrameName = "RegularHeal",
            Type = "spell",
            Spell = "Renewing Mist",
            Unit = masterUnit
        }
    elseif playerClassID == 11 then
        if DualBoxer.IsClassic then
            return {
                ButtonFrameName = "RegularHeal",
                Type = "spell",
                Spell = "Regrowth",
                Unit = masterUnit
            }
        else
            return {
                ButtonFrameName = "RegularHeal",
                Type = "spell",
                Spell = "Swiftmend",
                Unit = masterUnit
            }
        end
    end
end

function DualBoxer:ButtonDetails_Regen(masterUnit, playerClassID)
    if playerClassID == 10 then
        return {
            ButtonFrameName = "Regen",
            Type = "spell",
            Spell = "Enveloping Mist",
            Unit = masterUnit
        }
    elseif playerClassID == 11 then
        return {
            ButtonFrameName = "Regen",
            Type = "spell",
            Spell = "Rejuvenation",
            Unit = masterUnit
        }
    end
end

function DualBoxer:ButtonDetails_LightDirect(masterUnit, playerClassID)
    if playerClassID == 10 then
        return {
            ButtonFrameName = "LightDirect",
            Type = "spell",
            Spell = "Vivify",
            Unit = masterUnit
        }
    elseif playerClassID == 11 then
        if DualBoxer.Classic then
            return {
                ButtonFrameName = "LightDirect",
                Type = "spell",
                Spell = "Nourish",
                Unit = masterUnit
            }
        else
            return {
                ButtonFrameName = "LightDirect",
                Type = "spell",
                Spell = "Regrowth",
                Unit = masterUnit
            }
        end
    end
end

function DualBoxer:ButtonDetails_Buff(masterUnit, playerClassID)
    local frameName = "Buff"

    if playerClassID == 2 then
        return {
            ButtonFrameName = frameName,
            Type = "Spell",
            Spell = "Devotion Aura",
            Unit = "player"
        }
    elseif playerClassID == 11 then
        return {
            ButtonFrameName = frameName,
            Type = "spell",
            Spell = "Mark of the Wild",
            Unit = masterUnit,
            AllUnits = true
        }
    end
end

function DualBoxer:ButtonDetails_BuffTwo(masterUnit, playerClassID)
    local frameName = "BuffTwo"

    if playerClassID == 2 then
        return {
            ButtonFrameName = frameName,
            Type = "spell",
            Spell = "Beacon of Light",
            Unit = masterUnit,
            AllUnits = true
        }
    elseif playerClassID == 10 then
        return {
            ButtonFrameName = frameName,
            Type = "spell",
            Spell = "Life Cocoon",
            Unit = masterUnit,
            AllUnits = true
        }
    elseif playerClassID == 11 then
        if DualBoxer.IsClassic then
            return {
                ButtonFrameName = frameName,
                Type = "spell",
                Spell = "Thorns",
                Unit = masterUnit,
                AllUnits = true
            }
        else
            return {
                ButtonFrameName = frameName,
                Type = "spell",
                Spell = "Ironbark",
                Unit = masterUnit,
                AllUnits = true
            }
        end
    end
end

function DualBoxer:ButtonDetails_ClearDebuff(masterUnit, playerClassID)
    if playerClassID == 10 then
        return {
            ButtonFrameName = "ClearDebuff",
            Type = "spell",
            Spell = "Detox",
            Unit = masterUnit,
            AllUnits = true
        }
    elseif playerClassID == 11 then
        if DualBoxer.IsClassic then
            return {
                ButtonFrameName = "ClearDebuff",
                Type = "spell",
                Spell = "Remove Corruption",
                Unit = masterUnit,
                AllUnits = true
            }
        else
            return {
                ButtonFrameName = "ClearDebuff",
                Type = "spell",
                Spell = "Nature's Cure",
                Unit = masterUnit,
                AllUnits = true
            }
        end
    end
end

function DualBoxer:ButtonDetails_PartyHeal(masterUnit, playerClassID)
    if playerClassID == 10 then
        return {
            ButtonFrameName = "PartyHeal",
            Type = "spell",
            Spell = "Essence Font",
            Unit = masterUnit,
            AllUnits = true
        }
    elseif playerClassID == 11 then
        return {
            ButtonFrameName = "PartyHeal",
            Type = "spell",
            Spell = "Wild Growth",
            Unit = masterUnit,
            AllUnits = true
        }
    end
end

function DualBoxer:ButtonDetails_SelfRegularHeal(playerClassID)
    if playerClassID == 10 then
        return {
            ButtonFrameName = "SelfRegular",
            Type = "spell",
            Spell = "Renewing Mist",
            Unit = "player"
        }
    elseif playerClassID == 11 then
        if DualBoxer.IsClassic then
            return {
                ButtonFrameName = "SelfRegular",
                Type = "spell",
                Spell = "Regrowth",
                Unit = "player"
            }
        else
            return {
                ButtonFrameName = "SelfRegular",
                Type = "spell",
                Spell = "Swiftmend",
                Unit = "player"
            }
        end
    end
end

function DualBoxer:ButtonDetails_SelfPrimaryHeal(playerClassID)
    if playerClassID == 10 then
        -- return {
        --     ButtonFrameName = "PrimaryHeal",
        --     Type = "spell",
        --     Spell = "Soothing Mist",
        --     Unit = "player"
        -- }
    elseif playerClassID == 11 then
        if DualBoxer.IsClassic then
            return {
                ButtonFrameName = "SelfHeal",
                Type = "spell",
                Spell = "Healing Touch",
                Unit = "player"
            }
        else
            return {
                ButtonFrameName = "SelfHeal",
                Type = "spell",
                Spell = "Nourish",
                Unit = "player"
            }
        end
    end
end

function DualBoxer:ButtonDetails_SelfRegen(playerClassID)
    if playerClassID == 10 then
        return {
            ButtonFrameName = "SelfRegen",
            Type = "spell",
            Spell = "Enveloping Mist",
            Unit = "player"
        }
    elseif playerClassID == 11 then
        return {
            ButtonFrameName = "SelfRegen",
            Type = "spell",
            Spell = "Rejuvenation",
            Unit = "player"
        }
    end
end

function DualBoxer:ButtonDetails_SelfLight(playerClassID)
    if playerClassID == 10 then
        return {
            ButtonFrameName = "SelfLight",
            Type = "spell",
            Spell = "Vivify",
            Unit = "player"
        }
    elseif playerClassID == 11 then
        if DualBoxer.IsClassic then
            return {
                ButtonFrameName = "SelfLight",
                Type = "spell",
                Spell = "Nourish",
                Unit = "player"
            }
        else
            return {
                ButtonFrameName = "SelfLight",
                Type = "spell",
                Spell = "Regrowth",
                Unit = "player"
            }
        end
    end
end

function DualBoxer:ButtonDetails_Innervate(masterUnit, playerClassID)
    rc = {
        ButtonFrameName = "Innervate",
        Type = "spell"
    }

    if playerClassID == 10 then
        rc.Spell = "Zen Pulse"
        rc.Unit = masterUnit
        rc.AllUnits = true
    elseif playerClassID == 11 then
        if DualBoxer.IsClassic then
            rc.Spell = "Innervate"
            rc.Unit = masterUnit
            rc.AllUnits = true
        else
            rc.Spell = "Innervate"
            rc.Unit = "player"
            rc.AllUnits = true
        end
    end

    return rc
end

function DualBoxer:ButtonDetails_PetRegular(masterUnit, playerClassID)
    if playerClassID == 11 then
        if DualBoxer.IsClassic then
            return {
                ButtonFrameName = "PetRegular",
                Type = "spell",
                Spell = "Regrowth",
                Unit = masterUnit .. "pet"
            }
        else
            return {
                ButtonFrameName = "PetRegular",
                Type = "spell",
                Spell = "Swiftmend",
                Unit = masterUnit .. "pet"
            }
        end
    end
end

function DualBoxer:ButtonDetails_PetHeal(masterUnit, playerClassID)
    if playerClassID == 11 then
        if DualBoxer.IsClassic then
            return {
                ButtonFrameName = "PetHeal",
                Type = "spell",
                Spell = "Healing Touch",
                Unit = masterUnit .. "pet"
            }
        else
            return {
                ButtonFrameName = "PetHeal",
                Type = "spell",
                Spell = "Nourish",
                Unit = masterUnit .. "pet"
            }
        end
    end
end

function DualBoxer:ButtonDetails_PetRegen(masterUnit, playerClassID)
    if playerClassID == 11 then
        return {
            ButtonFrameName = "PetRegen",
            Type = "spell",
            Spell = "Rejuvenation",
            Unit = masterUnit .. "pet"
        }
    end
end

function DualBoxer:ButtonDetails_PetLight(masterUnit, playerClassID)
    if playerClassID == 11 then
        if DualBoxer.IsClassic then
            return {
                ButtonFrameName = "PetLight",
                Type = "spell",
                Spell = "Nourish",
                Unit = masterUnit .. "pet"
            }
        else
            return {
                ButtonFrameName = "PetLight",
                Type = "spell",
                Spell = "Regrowth",
                Unit = masterUnit .. "pet"
            }
        end
    end
end
