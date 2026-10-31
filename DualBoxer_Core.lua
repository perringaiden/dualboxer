---@diagnostic disable-next-line: create-global
DualBoxer = {}
DualBoxer.MessagePrefix = "DualBoxer"


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
    elseif strlower(command) == "testmessage" then
        DualBoxer:SendMessage(rest)
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
    dualBoxerWindow:RegisterEvent("QUEST_DETAIL")
    dualBoxerWindow:RegisterEvent("GOSSIP_CONFIRM")
    dualBoxerWindow:RegisterEvent("QUEST_FINISHED")
    dualBoxerWindow:RegisterEvent("QUEST_ACCEPTED")
    dualBoxerWindow:RegisterEvent("QUEST_COMPLETE")
    dualBoxerWindow:RegisterEvent("QUEST_LOG_UPDATE")
    dualBoxerWindow:RegisterEvent("QUEST_PROGRESS")
    dualBoxerWindow:RegisterEvent("QUEST_DETAIL")
    dualBoxerWindow:RegisterEvent("QUEST_ITEM_UPDATE")
    dualBoxerWindow:RegisterEvent("QUEST_WATCH_UPDATE")
    dualBoxerWindow:RegisterEvent("CHAT_MSG_ADDON")
    dualBoxerWindow:Hide()

    DualBoxer.Window = dualBoxerWindow
end

function DualBoxer.OnEvent(self, event, ...)
    if DualBoxer.Disabled ~= true then
        if event == "PLAYER_ENTERING_WORLD" then
            print("Player Entering World")
            DualBoxer:CommsInit()
            DualBoxer:EnsureSettings()
            DualBoxer:PrepareFrames()
            DualBoxer:UpdateLootMethod()

            DualBoxer:UpdateUI()
        elseif event == "PARTY_INVITE_REQUEST" then
            local acceptInvite = false
            local sender = ...


            if Wolf_Utilities:SetContains(DualBoxer_Settings.ApprovedCharacters, sender) then
                AcceptGroup()
                StaticPopup_Hide("PARTY_INVITE")
            end
        elseif event == "GROUP_ROSTER_UPDATE" then
            DualBoxer.DebugPrint("Group Roster Update")
            DualBoxer:UpdateLootMethod()
            DualBoxer:UpdateUI()
        elseif event == "QUEST_ACCEPT_CONFIRM" then
            local sender = ...

            DualBoxer.DebugPrint("Quest Accept Confirm:" .. sender)
            if Wolf_Utilities:SetContains(DualBoxer_Settings.ApprovedCharacters, sender) then
                ConfirmAcceptQuest()
                StaticPopup_Hide("QUEST_ACCEPT")
            end
        elseif event == "QUEST_ACCEPTED" then
            local questID = ...

            DualBoxer:QuestAccepted(questID)
        elseif event == "QUEST_DETAIL" then
            local questGiverGUID = UnitGUID("questnpc")

            if canaccessvalue(DualBoxer.MasterGUID) and
                canaccessvalue(questGiverGUID) and
                questGiverGUID == DualBoxer.MasterGUID then
                AcceptQuest()
            end
        elseif event == "CHAT_MSG_ADDON" then
            local receivedPrefix, text, channel, sender, target, zoneChannelID, localID, name, instanceID = ...

            if receivedPrefix == DualBoxer.MessagePrefix then
                local stringOpener = string.sub(text, 1, 1)
                DualBoxer.DebugPrint(format("Sender: %s Channel: %s Text: '%s'", sender, channel, text))

                if stringOpener == "{" then
                    local msgDetail = loadstring("return " .. text)()

                    if msgDetail ~= nil then
                        DualBoxer.DebugPrint(format("Quest MessageType: %s", msgDetail.messageType))

                        if msgDetail.messageType == "QUEST_UPDATE" then
                            DualBoxer:ProcessQuesUpdateMessage(sender, msgDetail)
                        else
                            for key, value in pairs(msgDetail) do
                                DualBoxer.DebugPrint(format("%s : %s", key, value))
                            end
                        end
                    end
                else
                    DualBoxer.DebugPrint(format("First Letter: %s", stringOpener))
                end
            end
        elseif event == "QUEST_WATCH_UPDATE" then
            local questID = ...

            DualBoxer.DebugPrint(format("Quest Update: %s", questID))

            C_Timer.After(0.5,
                function()
                    DualBoxer:QuestUpdate(questID)
                end
            )
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
            DualBoxer.MasterGUID = UnitGUID(masterUnit)
        elseif DualBoxer.Focus == true then
            print("Preparing for Focus")
            DualBoxer:FollowerButtons("focus")
            DualBoxer.MasterGUID = UnitGUID("focus")
        else
            print("Clearing buttons.")
            DualBoxer:ClearButtons()
            DualBoxer.MasterGUID = nil
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
