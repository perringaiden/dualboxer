function DualBoxer:SetDruidButtonDetails(buttonDetail)
    if buttonDetail ~= nil then
        if buttonDetail.ButtonFrameName == "FastRegen" then
            buttonDetail.Type = "spell"
            buttonDetail.Spell = "Rejuvenation"

            return buttonDetail
        elseif buttonDetail.ButtonFrameName == "Assist" then
            buttonDetail.Type = "spell"
            buttonDetail.Spell = "Wrath"

            return buttonDetail
        elseif buttonDetail.ButtonFrameName == "RegularHeal" then
            buttonDetail.Type = "spell"
            buttonDetail.Spell = "Regrowth"

            return buttonDetail
        elseif buttonDetail.ButtonFrameName == "PrimaryHeal" then
            buttonDetail.Type = "spell"
            buttonDetail.Spell = "Healing Touch"

            return buttonDetail
        elseif buttonDetail.ButtonFrameName == "Regen" then
            buttonDetail.Type = "spell"
            buttonDetail.Spell = "Rejuvenation"

            return buttonDetail
        elseif buttonDetail.ButtonFrameName == "LightDirect" then
            buttonDetail.Type = "spell"
            buttonDetail.Spell = "Nourish"

            return buttonDetail
        elseif buttonDetail.ButtonFrameName == "Follow" then
            local followUnitClassName, followUnitClassID = UnitClassBase(buttonDetail.Unit)

            if canaccessvalue(followUnitClassName) then
                DualBoxer.DebugPrint(
                    "Setting Follow Macro for Unit: " ..
                    tostring(buttonDetail.Unit) ..
                    "(" ..
                    tostring(followUnitClassName) ..
                    ")" ..
                    " on Frame: " ..
                    tostring(buttonDetail.ButtonFrameName)
                )
            else
                DualBoxer.DebugPrint(
                    "Setting Follow Macro for Unit: " ..
                    tostring(buttonDetail.Unit) ..
                    " on Frame: " ..
                    tostring(buttonDetail.ButtonFrameName)
                )
            end

            buttonDetail.Type = "macro"

            buttonDetail.MacroText = string.format("/follow %s", buttonDetail.Unit)

            if canaccessvalue(followUnitClassID) then
                buttonDetail.Texture = DualBoxer:ClassIDIcon(followUnitClassID)
            else
                buttonDetail.Texture = DualBoxer:ClassIDIcon(11)
            end

            return buttonDetail
        elseif buttonDetail.ButtonFrameName == "PartyHeal" then
            buttonDetail.Type = "spell"
            buttonDetail.Spell = "Wild Growth"

            return buttonDetail
        elseif buttonDetail.ButtonFrameName == "ClearDebuff" then
            buttonDetail.Type = "spell"
            buttonDetail.Spell = "Nature's Cure"

            return buttonDetail
        elseif buttonDetail.ButtonFrameName == "BuffTwo" then
            buttonDetail.Type = "spell"
            buttonDetail.Spell = "Thorns"

            return buttonDetail
        elseif buttonDetail.ButtonFrameName == "Buff" then
            buttonDetail.Type = "spell"
            buttonDetail.Spell = "Mark of the Wild"

            return buttonDetail
        elseif buttonDetail.ButtonFrameName == "Mount" then
            -- Find the appropriate mount in Collection.
            return nil
        elseif buttonDetail.ButtonFrameName == "SelfRegularHeal" then
            buttonDetail.Type = "spell"
            buttonDetail.Spell = "Regrowth"

            return buttonDetail
        elseif buttonDetail.ButtonFrameName == "SelfPrimaryHeal" then
            buttonDetail.Type = "spell"
            buttonDetail.Spell = "Healing Touch"

            return buttonDetail
        elseif buttonDetail.ButtonFrameName == "SelfRegen" then
            buttonDetail.Type = "spell"
            buttonDetail.Spell = "Rejuvenation"

            return buttonDetail
        elseif buttonDetail.ButtonFrameName == "SelfLight" then
            buttonDetail.Type = "spell"
            buttonDetail.Spell = "Nourish"

            return buttonDetail
        elseif buttonDetail.ButtonFrameName == "ManaSpecial" then
            buttonDetail.Type = "spell"
            buttonDetail.Spell = "Innervate"

            return buttonDetail
        elseif buttonDetail.ButtonFrameName == "PetRegularHeal" then
            buttonDetail.Type = "spell"
            buttonDetail.Spell = "Swiftmend"

            return buttonDetail
        elseif buttonDetail.ButtonFrameName == "PetPrimaryHeal" then
            buttonDetail.Type = "spell"
            buttonDetail.Spell = "Healing Touch"

            return buttonDetail
        elseif buttonDetail.ButtonFrameName == "PetRegen" then
            buttonDetail.Type = "spell"
            buttonDetail.Spell = "Rejuvenation"

            return buttonDetail
        elseif buttonDetail.ButtonFrameName == "PetLightHeal" then
            buttonDetail.Type = "spell"
            buttonDetail.Spell = "Nourish"

            return buttonDetail
        end
    end
end
