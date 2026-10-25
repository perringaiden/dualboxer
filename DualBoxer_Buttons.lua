DualBoxer.ButtonFrameList = {
    {Key = "FastRegen", Name = "DBHButton_FastRegen", Row = 0, Column = 1, Binding = "H"},
    {Key = "Assist", Name = "DBHButton_Assist", Row = 0, Column = 2, Binding = "V"},
    {Key = "RegularHeal", Name = "DBHButton_Regular", Row = 1, Column = 0, Binding = "K"},
    {Key = "PrimaryHeal", Name = "DBHButton_Primary", Row = 1, Column = 1, Binding = "N"},
    {Key = "Regen", Name = "DBHButton_Regen", Row = 1, Column = 2, Binding = "M"},
    {Key = "LightDirect", Name = "DBHButton_LightDirect", Row = 1, Column = 3, Binding = "B"},
    {Key = "Follow", Name = "DBHButton_Follow", Row = 1, Column = 4, Binding = "."},
    {Key = "PartyHeal", Name = "DBHButton_PartyHeal", Row = 2, Column = 0, Binding = "Z"},
    {Key = "ClearDebuff", Name = "DBHButton_ClearDebuff", Row = 2, Column = 1, Binding = "X"},
    {Key = "BuffTwo", Name = "DBHButton_BuffTwo", Row = 2, Column = 2, Binding = "C"},
    {Key = "Buff", Name = "DBHButton_Buff", Row = 2, Column = 3, Binding = "T"},
    {Key = "Mount", Name = "DBHButton_Mount", Row = 2, Column = 4, Binding = ","},
    {Key = "SelfRegular", Name = "DBHButton_SelfRegular", Row = 3, Column = 0, Binding = "A"},
    {Key = "SelfHeal", Name = "DBHButton_SelfHeal", Row = 3, Column = 1, Binding = "S"},
    {Key = "SelfRegen", Name = "DBHButton_SelfRegen", Row = 3, Column = 2, Binding = "D"},
    {Key = "SelfLight", Name = "DBHButton_SelfLight", Row = 3, Column = 3, Binding = "F"},
    {Key = "Innervate", Name = "DBHButton_Innervate", Row = 3, Column = 4, Binding = "G"},
    {Key = "PetRegular", Name = "DBHButton_PetRegular", Row = 4, Column = 0, Binding = "Q"},
    {Key = "PetHeal", Name = "DBHButton_PetHeal", Row = 4, Column = 1, Binding = "W"},
    {Key = "PetRegen", Name = "DBHButton_PetRegen", Row = 4, Column = 2, Binding = "E"},
    {Key = "PetLight", Name = "DBHButton_PetLight", Row = 4, Column = 3, Binding = "R"},
    {Key = "ResetFocus", Name = "DBHButton_ResetFocus", Row = 4, Column = 4, Binding = "O"}
}

function DualBoxer:PrepareFrames()
    DualBoxer.ButtonFrameParent = BuildBaseFrame()

    DualBoxer.ButtonFrames = {}
    DualBoxer.ButtonTextures = {}

    for i, frame in ipairs(DualBoxer.ButtonFrameList) do
        if frame ~= nil then
            DualBoxer.ButtonFrames[frame.Key] = BuildFrame(frame.Name, frame.Row, frame.Column)
            DualBoxer:BuildFrameTexture(DualBoxer.ButtonFrames[frame.Key], frame.Key, frame.Name)
        end
    end

    DualBoxer.BindingFrame = BuildFrame("DBRBindings", -1, -1, nil, nil)
end

function BuildBaseFrame()
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

function BuildFrame(name, row, column, bindingKey)
    local buttonFrame = CreateFrame("Button", name, DualBoxer.ButtonFrameParent, "SecureActionButtonTemplate")
    buttonFrame:SetSize(32, 32)
    buttonFrame:SetPoint("BOTTOMLEFT", column * 32, row * 32)
    buttonFrame:RegisterForClicks("AnyDown")
    buttonFrame:EnableMouse(true)

    buttonFrame:Hide()

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

function DualBoxer:FollowerButtons(masterUnit)
    print("DBR: Preparing Party Member Buttons.")
    local playerClassName, playerClassID = UnitClassBase("player")
    local senderClassName, senderClassID = UnitClassBase(masterUnit)
    local spellList =
        DualBoxer:GenerateSpellList(
        playerClassID,
        UnitLevel("player"),
        masterUnit,
        UnitLevel(masterUnit),
        senderClassID
    )

    if masterUnit == "focus" then
        Utilities:InsertInTable(spellList, DualBoxer:ButtonDetails_ResetFocus(masterUnit, senderClassID)) -- O
    end

    print("DBR: Applying Spell List")
    DualBoxer:ApplySpellList(spellList)
    DualBoxer:SetBindings()
    DualBoxer.ButtonFrameParent:Show()
end

function DualBoxer:SetBindings()
    DualBoxer:ClearBindings()

    for i, value in ipairs(DualBoxer.ButtonFrameList) do
        SetOverrideBindingClick(DualBoxer.BindingFrame, false, value.Binding, value.Name, "LeftButton")
    end

    SetOverrideBinding(DualBoxer.BindingFrame, false, "NUMPADMINUS", "JUMP")
    SetOverrideBinding(DualBoxer.BindingFrame, false, "F1", "OPENALLBAGS")
    SetOverrideBinding(DualBoxer.BindingFrame, false, "F2", "TOGGLEQUESTLOG")
    SetOverrideBinding(DualBoxer.BindingFrame, false, "F3", "TOGGLECHARACTER0")
    SetOverrideBinding(DualBoxer.BindingFrame, false, "F4", "TOGGLEPROFESSIONBOOK")
    SetOverrideBinding(DualBoxer.BindingFrame, false, "F5", "TOGGLECHARACTER2")
    SetOverrideBinding(DualBoxer.BindingFrame, false, "F6", "TOGGLETALENTS")
end

function DualBoxer:ClearBindings()
    ClearOverrideBindings(DualBoxer.BindingFrame)
end

function DualBoxer:ApplySpellList(list)
    for key, value in pairs(DualBoxer.ButtonFrames) do
        value:Hide()
        DualBoxer.ButtonTextures[key]:SetTexture(134532)
    end

    print("Button Count: " .. table.getn(list))

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
                            buttonFrame:SetAttribute("ctrl-unit*", "player")
                            buttonFrame:SetAttribute("alt-unit*", value.Unit .. "pet")
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
    local rc = {}

    Utilities:InsertInTable(rc, DualBoxer:ButtonDetails_FastRegen(masterUnit, playerClassID, playerLevel)) -- H
    Utilities:InsertInTable(rc, DualBoxer:ButtonDetails_Assist(masterUnit, playerClassID, playerLevel)) -- V
    Utilities:InsertInTable(rc, DualBoxer:ButtonDetails_RegularHeal(masterUnit, playerClassID, playerLevel)) -- K
    Utilities:InsertInTable(rc, DualBoxer:ButtonDetails_PrimaryHeal(masterUnit, playerClassID, playerLevel)) -- N
    Utilities:InsertInTable(rc, DualBoxer:ButtonDetails_Regen(masterUnit, playerClassID, playerLevel)) -- M
    Utilities:InsertInTable(rc, DualBoxer:ButtonDetails_LightDirect(masterUnit, playerClassID, playerLevel)) -- B
    Utilities:InsertInTable(rc, DualBoxer:ButtonDetails_Follow(masterUnit, masterClassID)) -- .
    Utilities:InsertInTable(rc, DualBoxer:ButtonDetails_PartyHeal(masterUnit, playerClassID, playerLevel)) -- Z
    Utilities:InsertInTable(rc, DualBoxer:ButtonDetails_ClearDebuff(masterUnit, playerClassID, playerLevel)) -- X
    Utilities:InsertInTable(rc, DualBoxer:ButtonDetails_BuffTwo(masterUnit, playerClassID, playerLevel)) -- C
    Utilities:InsertInTable(rc, DualBoxer:ButtonDetails_Buff(masterUnit, playerClassID, playerLevel)) -- T
    Utilities:InsertInTable(rc, DualBoxer:ButtonDetails_Mount(playerClassID)) -- ,
    Utilities:InsertInTable(rc, DualBoxer:ButtonDetails_SelfRegularHeal(playerClassID, playerLevel)) -- A
    Utilities:InsertInTable(rc, DualBoxer:ButtonDetails_SelfPrimaryHeal(playerClassID, playerLevel)) -- S
    Utilities:InsertInTable(rc, DualBoxer:ButtonDetails_SelfRegen(playerClassID, playerLevel)) -- D
    Utilities:InsertInTable(rc, DualBoxer:ButtonDetails_SelfLight(playerClassID, playerLevel)) -- F
    Utilities:InsertInTable(rc, DualBoxer:ButtonDetails_Innervate(masterUnit, playerClassID, playerLevel)) -- G

    if DualBoxer:ClassIDsWithPets(masterClassID) then
        Utilities:InsertInTable(rc, DualBoxer:ButtonDetails_PetRegular(masterUnit, playerClassID, playerLevel)) -- Q
        Utilities:InsertInTable(rc, DualBoxer:ButtonDetails_PetHeal(masterUnit, playerClassID, playerLevel)) -- W
        Utilities:InsertInTable(rc, DualBoxer:ButtonDetails_PetRegen(masterUnit, playerClassID, playerLevel)) -- E
        Utilities:InsertInTable(rc, DualBoxer:ButtonDetails_PetLight(masterUnit, playerClassID, playerLevel)) -- R
    end

    -- Update UI -- O

    return rc
end

function DualBoxer:ButtonDetails_Follow(masterUnit, classID)
    return {
        ButtonFrameName = "Follow",
        Type = "macro",
        MacroText = "/follow " .. masterUnit,
        Texture = DualBoxer:ClassIDIcon(classID)
    }
end

function DualBoxer:ButtonDetails_ResetFocus(masterUnit, masterUnitClassID)
    return {
        ButtonFrameName = "ResetFocus",
        Type = "macro",
        MacroText = "/target " .. UnitName(masterUnit) .. "\n/focus",
        Texture = DualBoxer:ClassIDIcon(masterUnitClassID)
    }
end
