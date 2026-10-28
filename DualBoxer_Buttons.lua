DualBoxer.ButtonFrameList = {
    { Key = "FastRegen",       Name = "DBHButton_FastRegen" },
    { Key = "Assist",          Name = "DBHButton_Assist" },
    { Key = "RegularHeal",     Name = "DBHButton_Regular" },
    { Key = "PrimaryHeal",     Name = "DBHButton_Primary" },
    { Key = "Regen",           Name = "DBHButton_Regen" },
    { Key = "LightDirect",     Name = "DBHButton_LightDirect" },
    { Key = "Follow",          Name = "DBHButton_Follow" },
    { Key = "PartyHeal",       Name = "DBHButton_PartyHeal" },
    { Key = "ClearDebuff",     Name = "DBHButton_ClearDebuff" },
    { Key = "BuffTwo",         Name = "DBHButton_BuffTwo" },
    { Key = "Buff",            Name = "DBHButton_Buff" },
    { Key = "Mount",           Name = "DBHButton_Mount" },
    { Key = "SelfRegularHeal", Name = "DBHButton_SelfRegular" },
    { Key = "SelfPrimaryHeal", Name = "DBHButton_SelfPrimary" },
    { Key = "SelfRegen",       Name = "DBHButton_SelfRegen" },
    { Key = "SelfLight",       Name = "DBHButton_SelfLight" },
    { Key = "ManaSpecial",     Name = "DBHButton_ManaSpecial" },
    { Key = "PetRegularHeal",  Name = "DBHButton_PetRegular" },
    { Key = "PetPrimaryHeal",  Name = "DBHButton_PetPrimary" },
    { Key = "PetRegen",        Name = "DBHButton_PetRegen" },
    { Key = "PetLightHeal",    Name = "DBHButton_PetLight" },
    { Key = "ResetFocus",      Name = "DBHButton_ResetFocus" }

}

DualBoxer.ButtonFrameNames = {
    FastRegen = "DBHButton_FastRegen",
    Assist = "DBHButton_Assist",
    RegularHeal = "DBHButton_Regular",
    PrimaryHeal = "DBHButton_Primary",
    Regen = "DBHButton_Regen",
    LightDirect = "DBHButton_LightDirect",
    Follow = "DBHButton_Follow",
    PartyHeal = "DBHButton_PartyHeal",
    ClearDebuff = "DBHButton_ClearDebuff",
    BuffTwo = "DBHButton_BuffTwo",
    Buff = "DBHButton_Buff",
    Mount = "DBHButton_Mount",
    SelfRegularHeal = "DBHButton_SelfRegular",
    SelfPrimaryHeal = "DBHButton_SelfPrimary",
    SelfRegen = "DBHButton_SelfRegen",
    SelfLight = "DBHButton_SelfLight",
    ManaSpecial = "DBHButton_ManaSpecial",
    PetRegularHeal = "DBHButton_PetRegular",
    PetPrimaryHeal = "DBHButton_PetPrimary",
    PetRegen = "DBHButton_PetRegen",
    PetLightHeal = "DBHButton_PetLight",
    ResetFocus = "DBHButton_ResetFocus"
}


DualBoxer.ButtonFrameList_T9 = {
    { Key = "FastRegen",       Row = 0, Column = 1, Binding = "H" },
    { Key = "Assist",          Row = 0, Column = 2, Binding = "V" },
    { Key = "RegularHeal",     Row = 1, Column = 0, Binding = "K" },
    { Key = "PrimaryHeal",     Row = 1, Column = 1, Binding = "N" },
    { Key = "Regen",           Row = 1, Column = 2, Binding = "M" },
    { Key = "LightDirect",     Row = 1, Column = 3, Binding = "B" },
    { Key = "Follow",          Row = 1, Column = 4, Binding = "." },
    { Key = "PartyHeal",       Row = 2, Column = 0, Binding = "Z" },
    { Key = "ClearDebuff",     Row = 2, Column = 1, Binding = "X" },
    { Key = "BuffTwo",         Row = 2, Column = 2, Binding = "C" },
    { Key = "Buff",            Row = 2, Column = 3, Binding = "T" },
    { Key = "Mount",           Row = 2, Column = 4, Binding = "," },
    { Key = "SelfRegularHeal", Row = 3, Column = 0, Binding = "A" },
    { Key = "SelfPrimaryHeal", Row = 3, Column = 1, Binding = "S" },
    { Key = "SelfRegen",       Row = 3, Column = 2, Binding = "D" },
    { Key = "SelfLight",       Row = 3, Column = 3, Binding = "F" },
    { Key = "ManaSpecial",     Row = 3, Column = 4, Binding = "G" },
    { Key = "PetRegularHeal",  Row = 4, Column = 0, Binding = "Q" },
    { Key = "PetPrimaryHeal",  Row = 4, Column = 1, Binding = "W" },
    { Key = "PetRegen",        Row = 4, Column = 2, Binding = "E" },
    { Key = "PetLightHeal",    Row = 4, Column = 3, Binding = "R" },
    { Key = "ResetFocus",      Row = 4, Column = 4, Binding = "O" }
}

DualBoxer.ButtonFrameList_KeyPad = {
    { Key = "Assist",      Row = 0, Column = 2, Binding = "NUMPADDECIMAL" },
    { Key = "RegularHeal", Row = 1, Column = 0, Binding = "NUMPAD1" },
    { Key = "PrimaryHeal", Row = 1, Column = 1, Binding = "NUMPAD2" },
    { Key = "FastRegen",   Row = 1, Column = 2, Binding = "NUMPAD3" },
    { Key = "Follow",      Row = 1, Column = 3, Binding = "ENTER" },
    { Key = "ClearDebuff", Row = 2, Column = 0, Binding = "NUMPAD4" },
    { Key = "Buff",        Row = 2, Column = 3, Binding = "NUMPAD6" },
    { Key = "ResetFocus",  Row = 3, Column = 3, Binding = "NUMPADPLUS" }
}

function DualBoxer:PrepareFrames()
    DualBoxer.ButtonFrameParent = DualBoxer:BuildBaseFrame()

    DualBoxer.ButtonFrames = {}
    DualBoxer.ButtonTextures = {}

    for key, name in pairs(DualBoxer.ButtonFrameNames) do
        DualBoxer.DebugPrint("Preparing Frame: " .. tostring(name) .. " for Key: " .. tostring(key))
        DualBoxer.ButtonFrames[key] = DualBoxer:BuildFrame(name)
        DualBoxer:BuildFrameTexture(DualBoxer.ButtonFrames[key], key, name)

        DualBoxer.DebugPrint("Frame: " .. tostring(key) .. " is " .. tostring(DualBoxer.ButtonFrames[key]))
    end

    DualBoxer.BindingFrame = DualBoxer:BuildFrame("DBRBindings")
end

function DualBoxer:BuildBaseFrame()
    local rc = CreateFrame("Frame", "DBRButton_Frame", UIParent, "SecureFrameTemplate")

    rc:SetPoint("TOPLEFT", DualBoxer_Settings.XCoord, DualBoxer_Settings.YCoord)
    rc:SetSize(32 * 5, 32 * 5)
    rc:SetMovable(true)
    rc:RegisterForDrag("LeftButton")

    rc.tex = rc:CreateTexture("DBRButton_FrameTexture", "ARTWORK")
    rc.tex:SetAllPoints()
    rc.tex:SetColorTexture(1.0, 0, 0)
    rc.tex:Hide()

    rc:SetScript(
        "OnDragStart",
        function(self, button)
            self:StartMoving()
        end
    )

    rc:SetScript(
        "OnDragStop",
        function(self)
            local point, relativePoint, relativeTo, x, y = self:GetPoint()

            DualBoxer_Settings.XCoord = x
            DualBoxer_Settings.YCoord = y
            self:StopMovingOrSizing()
        end
    )

    rc:Hide()

    return rc
end

function DualBoxer:BuildFrame(name)
    local buttonFrame = CreateFrame("Button", name, DualBoxer.ButtonFrameParent, "SecureActionButtonTemplate")
    buttonFrame:SetSize(32, 32)
    buttonFrame:SetPoint("BOTTOMLEFT", -32, -32)
    buttonFrame:RegisterForClicks("AnyDown")
    buttonFrame:EnableMouse(true)

    return buttonFrame
end

function DualBoxer:BuildFrameTexture(frame, key, name)
    local tex = frame:CreateTexture(name, "BACKGROUND")

    tex:SetTexture("interface\\icons\\inv_mushroom_11")
    tex:SetAllPoints()

    DualBoxer.ButtonTextures[key] = tex
end

function DualBoxer:ClearButtons()
    for key, value in pairs(DualBoxer.ButtonFrames) do
        value:Hide()
    end

    DualBoxer:ClearBindings()
end

function DualBoxer:UpdateFrames()
    local buttonList =
        (DualBoxer_Settings.UseT9 and DualBoxer.ButtonFrameList_T9) or
        DualBoxer.ButtonFrameList_KeyPad


    for key, frame in pairs(buttonList) do
        if frame ~= nil then
            local buttonFrame = DualBoxer.ButtonFrames[frame.Key]

            if buttonFrame ~= nil then
                buttonFrame:ClearAllPoints()
                buttonFrame:SetPoint("BOTTOMLEFT", frame.Column * 32, frame.Row * 32)
            end
        end
    end
end

function DualBoxer:FollowerButtons(masterUnit)
    print("DBR: Preparing Party Member Buttons.")
    local playerClassName, playerClassID = UnitClassBase("player")
    local senderClassName, senderClassID = UnitClassBase(masterUnit)
    local spellList = DualBoxer:GenerateSpellList(
        playerClassID,
        UnitLevel("player"),
        masterUnit,
        UnitLevel(masterUnit),
        senderClassID
    )

    if masterUnit == "focus" then
        Wolf_Utilities:InsertInTable(spellList, DualBoxer:ButtonDetails_ResetFocus(masterUnit, senderClassID)) -- O
    end

    print("DBR: Applying Spell List")
    DualBoxer:ApplySpellList(spellList)
    DualBoxer:UpdateFrames()
    DualBoxer:SetBindings()
    DualBoxer.ButtonFrameParent:Show()
end

function DualBoxer:SetBindings()
    DualBoxer:ClearBindings()

    local bindingList =
        (DualBoxer_Settings.UseT9 and DualBoxer.ButtonFrameList_T9) or
        DualBoxer.ButtonFrameList_KeyPad

    for i, value in ipairs(bindingList) do
        local buttonName = DualBoxer.ButtonFrameNames[value.Key]

        if buttonName ~= nil then
            DualBoxer.DebugPrint(
                "Setting Binding: " ..
                tostring(value.Binding) .. " for Frame: " .. tostring(buttonName)
            )

            SetOverrideBindingClick(
                DualBoxer.BindingFrame,
                false,
                value.Binding,
                buttonName,
                "LeftButton")
        else
            DualBoxer.DebugPrint("Couldn't find frame for :" .. tostring(value.Key))
        end
    end

    SetOverrideBinding(DualBoxer.BindingFrame, false, "NUMPADMINUS", "JUMP")

    if DualBoxer_Settings.UseT9 then
        SetOverrideBinding(DualBoxer.BindingFrame, false, "F1", "OPENALLBAGS")
        SetOverrideBinding(DualBoxer.BindingFrame, false, "F2", "TOGGLEQUESTLOG")
        SetOverrideBinding(DualBoxer.BindingFrame, false, "F3", "TOGGLECHARACTER0")
        SetOverrideBinding(DualBoxer.BindingFrame, false, "F4", "TOGGLEPROFESSIONBOOK")
        SetOverrideBinding(DualBoxer.BindingFrame, false, "F5", "TOGGLECHARACTER2")
        SetOverrideBinding(DualBoxer.BindingFrame, false, "F6", "TOGGLETALENTS")
    end
end

function DualBoxer:ClearBindings()
    ClearOverrideBindings(DualBoxer.BindingFrame)
end

function DualBoxer:ApplySpellList(list)
    for key, value in pairs(DualBoxer.ButtonFrames) do
        value:Hide()
        DualBoxer.ButtonTextures[key]:SetTexture(134532)
    end

    print("Button Count: " .. #list)

    for i, value in pairs(list) do
        if value ~= nil then
            -- Ensure we reset any textures that were already
            -- set, so that we don't have leftovers.
            local textureFile = 134532 -- Mushroom.

            if DualBoxer.ButtonFrames[value.ButtonFrameName] ~= nil then
                local buttonFrame = DualBoxer.ButtonFrames[value.ButtonFrameName]

                if buttonFrame ~= nil then
                    buttonFrame:SetAttribute("type", value.Type)

                    if value.Type == "macro" then
                        buttonFrame:SetAttribute("macroText", value.MacroText)
                        if value.Texture ~= nil then
                            textureFile = value.Texture
                        end
                        print(value.MacroText)
                    elseif value.Type == "spell" then
                        DualBoxer.DebugPrint(
                            "Setting Spell: " ..
                            tostring(value.Spell) ..
                            " for Unit: " ..
                            tostring(value.Unit) .. " on Frame: " .. tostring(value.ButtonFrameName)
                        )

                        buttonFrame:SetAttribute("spell", value.Spell)
                        buttonFrame:SetAttribute("unit", value.Unit)

                        if value.AllUnits == true then
                            buttonFrame:SetAttribute("alt-unit*", "player")
                            buttonFrame:SetAttribute("ctrl-unit*", value.Unit .. "pet")
                        end

                        textureFile = C_Spell.GetSpellTexture(value.Spell)
                    end

                    DualBoxer.ButtonTextures[value.ButtonFrameName]:SetTexture(textureFile)
                    buttonFrame:Show()
                else
                    print("Frame " .. value.ButtonFrameName .. " was nil.")
                end
            else
                print("Couldn't find frame for :" .. tostring(value.ButtonFrameName))
            end
        end
    end
end

function DualBoxer:GenerateSpellList(playerClassID, playerLevel, masterUnit, masterLevel, masterClassID)
    local list = {}

    Wolf_Utilities:InsertInTable(list, DualBoxer:ButtonDetails_Assist(masterUnit, playerClassID, playerLevel)) -- V
    Wolf_Utilities:InsertInTable(list, DualBoxer:ButtonDetails_RegularHeal(masterUnit, playerClassID))         -- K
    Wolf_Utilities:InsertInTable(list, DualBoxer:ButtonDetails_Follow(masterUnit, masterClassID))              -- .
    Wolf_Utilities:InsertInTable(list, DualBoxer:ButtonDetails_PrimaryHeal(masterUnit, playerClassID))         -- N
    Wolf_Utilities:InsertInTable(list, DualBoxer:ButtonDetails_Buff(masterUnit, playerClassID))                -- T
    Wolf_Utilities:InsertInTable(list, DualBoxer:ButtonDetails_FastRegen(masterUnit, playerClassID))           -- H

    if DualBoxer_Settings.UseT9 then
        Wolf_Utilities:InsertInTable(list, DualBoxer:ButtonDetails_Regen(masterUnit, playerClassID))       -- M
        Wolf_Utilities:InsertInTable(list, DualBoxer:ButtonDetails_LightDirect(masterUnit, playerClassID)) -- B
        Wolf_Utilities:InsertInTable(list, DualBoxer:ButtonDetails_PartyHeal(masterUnit, playerClassID))   -- Z
        Wolf_Utilities:InsertInTable(list, DualBoxer:ButtonDetails_ClearDebuff(masterUnit, playerClassID)) -- X
        Wolf_Utilities:InsertInTable(list, DualBoxer:ButtonDetails_BuffTwo(masterUnit, playerClassID))     -- C
        Wolf_Utilities:InsertInTable(list, DualBoxer:ButtonDetails_Mount(playerClassID))                   -- ,
        Wolf_Utilities:InsertInTable(list, DualBoxer:ButtonDetails_SelfRegularHeal(playerClassID))         -- A
        Wolf_Utilities:InsertInTable(list, DualBoxer:ButtonDetails_SelfPrimaryHeal(playerClassID))         -- S
        Wolf_Utilities:InsertInTable(list, DualBoxer:ButtonDetails_SelfRegen(playerClassID))               -- D
        Wolf_Utilities:InsertInTable(list, DualBoxer:ButtonDetails_SelfLight(playerClassID))               -- F
        Wolf_Utilities:InsertInTable(list, DualBoxer:ButtonDetails_ManaSpecial(masterUnit, playerClassID)) -- G

        if DualBoxer:ClassIDsWithPets(masterClassID) then
            Wolf_Utilities:InsertInTable(list, DualBoxer:ButtonDetails_PetRegularHeal(masterUnit, playerClassID)) -- Q
            Wolf_Utilities:InsertInTable(list, DualBoxer:ButtonDetails_PetPrimaryHeal(masterUnit, playerClassID)) -- W
            Wolf_Utilities:InsertInTable(list, DualBoxer:ButtonDetails_PetRegen(masterUnit, playerClassID))       -- E
            Wolf_Utilities:InsertInTable(list, DualBoxer:ButtonDetails_PetLightHeal(masterUnit, playerClassID))   -- R
        end
    end

    return list
end

function DualBoxer:ButtonDetails_ResetFocus(masterUnit, masterUnitClassID)
    return {
        ButtonFrameName = "ResetFocus",
        Type = "macro",
        MacroText = "/target " .. UnitName(masterUnit) .. "\n/focus",
        Texture = DualBoxer:ClassIDIcon(masterUnitClassID)
    }
end
