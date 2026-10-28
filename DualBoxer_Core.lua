---@diagnostic disable-next-line: create-global
DualBoxer = {}

SLASH_DBRCMD1, SLASH_DBRCMD2 = "/dbr", "/dualboxer"

function DualBoxer.CommandHandler(msg, editBox)
    local command, rest = msg:match("^(%S*)%s*(.-)$")

    if DualBoxer_Settings.Debug then
        print("Command: " .. command)
        print("Rest:" .. rest)
    end

    if strlower(command) == "reset" then
    elseif strlower(command) == "addinviter" then
        DualBoxer:AddInviter(rest)
    elseif strlower(command) == "inviters" then
        -- Unknown why this triggers.
        ---@diagnostic disable-next-line: missing-parameter
        DualBoxer.ListInviters()
    elseif strlower(command) == "follower" then
        DualBoxer_Settings.Follower = true
    elseif strlower(command) == "leader" then
        DualBoxer_Settings.Follower = false
    elseif strlower(command) == "uset9" then
        DualBoxer_Settings.UseT9 = not DualBoxer_Settings.UseT9

        DualBoxer:UpdateUI()
    elseif strlower(command) == "focus" then
        if UnitExists("focus") then
            DualBoxer.Focus = true
        else
            DualBoxer.Focus = false
        end
        DualBoxer:UpdateUI()
    elseif strlower(command) == "unlock" then
        --DualBoxer.ButtonFrameDrag:Show()
        DualBoxer.ButtonFrameParent:EnableMouse(true)
        DualBoxer.ButtonFrameParent.tex:Show()
    elseif strlower(command) == "lock" then
        --DualBoxer.ButtonFrameDrag:Hide()
        DualBoxer.ButtonFrameParent:EnableMouse(false)
        DualBoxer.ButtonFrameParent.tex:Hide()
    elseif strlower(command) == "debug" then
        DualBoxer_Settings.Debug = not DualBoxer_Settings.Debug

        print("Debug is: " .. tostring(DualBoxer_Settings.Debug))
    end
end

SlashCmdList["DBRCMD"] = DualBoxer.CommandHandler

function DualBoxer.CreateEventFrame()
    print("Creating Event Frame")
    local dualBoxerWindow =
        CreateFrame("Frame", "DualBoxerEvents", UIParent, BackdropTemplateMixin and "BackdropTemplate")
    dualBoxerWindow:SetPoint("BOTTOMLEFT", 0, 0)
    dualBoxerWindow:SetSize(0, 0)
    dualBoxerWindow:SetScript("OnEvent", DualBoxer.OnEvent)
    dualBoxerWindow:RegisterEvent("PLAYER_ENTERING_WORLD")
    dualBoxerWindow:RegisterEvent("PARTY_INVITE_REQUEST")
    dualBoxerWindow:RegisterEvent("GROUP_ROSTER_UPDATE")
    dualBoxerWindow:RegisterEvent("ADDON_LOADED")
    dualBoxerWindow:RegisterEvent("GOSSIP_SHOW")
    dualBoxerWindow:RegisterEvent("GOSSIP_CLOSED")
    dualBoxerWindow:RegisterEvent("QUEST_GREETING")
    dualBoxerWindow:RegisterEvent("QUEST_ACCEPT_CONFIRM")
    dualBoxerWindow:RegisterEvent("GOSSIP_CONFIRM")
    dualBoxerWindow:RegisterEvent("QUEST_FINISHED")
    dualBoxerWindow:RegisterEvent("QUEST_ACCEPTED")
    dualBoxerWindow:RegisterEvent("QUEST_LOG_UPDATE")
    dualBoxerWindow:RegisterEvent("QUEST_PROGRESS")
    dualBoxerWindow:RegisterEvent("QUEST_DETAIL")
    dualBoxerWindow:RegisterEvent("QUEST_ITEM_UPDATE")
    dualBoxerWindow:Hide()

    DualBoxer.Window = dualBoxerWindow
end

function DualBoxer.OnEvent(self, event, sender, ...)
    if DualBoxer.Disabled ~= true then
        if event == "PLAYER_ENTERING_WORLD" then
            print("Player Entering World")
            DualBoxer:EnsureSettings()
            DualBoxer:PrepareFrames()
            DualBoxer:UpdateLootMethod()

            DualBoxer:UpdateUI()
        elseif event == "PARTY_INVITE_REQUEST" then
            local acceptInvite = false

            if Wolf_Utilities:SetContains(DualBoxer_Settings.ApprovedCharacters, sender) then
                AcceptGroup()
                StaticPopup_Hide("PARTY_INVITE")
            end
        elseif event == "GROUP_ROSTER_UPDATE" then
            DualBoxer.DebugPrint("Group Roster Update")
            DualBoxer:UpdateLootMethod()
            DualBoxer:UpdateUI()
        elseif event == "QUEST_ACCEPT_CONFIRM" then
            DualBoxer.DebugPrint("Quest Accept Confirm:" .. sender)
            if Wolf_Utilities:SetContains(DualBoxer_Settings.ApprovedCharacters, sender) then
                ConfirmAcceptQuest()
                StaticPopup_Hide("QUEST_ACCEPT")
            end
        end
    end
end

function DualBoxer.EnsureSettings()
    print("Ensuring Settings")
    if DualBoxer_Settings == nil then
        DualBoxer_Settings = {}
    end

    if DualBoxer_Settings.Debug == nil then
        DualBoxer_Settings.Debug = false
    end

    if DualBoxer_Settings.ApprovedCharacters == nil then
        DualBoxer_Settings.ApprovedCharacters = {}
    end

    if DualBoxer_Settings.Follower == nil then
        DualBoxer_Settings.Follower = false
    end

    if DualBoxer_Settings.UseT9 == nil then
        DualBoxer_Settings.UseT9 = false
    end
end

function DualBoxer:UpdateUI()
    if DualBoxer_Settings.Follower then
        local masterUnit = DualBoxer:FindApprovedMemberUnit()

        if masterUnit ~= nil then
            print("Preparing for Master:" .. tostring(masterUnit) .. " (" .. UnitName(masterUnit) .. ")")
            DualBoxer:FollowerButtons(masterUnit)
        elseif DualBoxer.Focus == true then
            print("Preparing for Focus")
            DualBoxer:FollowerButtons("focus")
        else
            print("Clearing buttons.")
            DualBoxer:ClearButtons()
        end
    else
        DualBoxer:ClearButtons()
    end
end

function DualBoxer:SetVersion()
    local version = GetBuildInfo()
    local start, finish = string.find(version, "%.")

    if tonumber(string.sub(version, 0, start)) >= 10 then
        DualBoxer.IsClassic = false
    else
        DualBoxer.IsClassic = true
    end
end

local function init()
    -- Note that you can only call things within this file until Player Enters World.
    DualBoxer:SetVersion()

    DualBoxer:CreateEventFrame()
end

init()
