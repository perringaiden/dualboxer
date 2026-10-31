function DualBoxer:QuestUpdate(questID)
    local objectives = C_QuestLog.GetQuestObjectives(questID)
    local unfulfilled = false

    DualBoxer.DebugPrint(format("Quest ID %s updated.", questID))

    C_Timer.After(1, function()
        for i, objective in ipairs(objectives) do
            if objective ~= nil and objective.finished == false then
                DualBoxer.DebugPrint(format("Quest ID %s has unfulfilled objective. %s", questID, objective.text))
                unfulfilled = true
            end
        end

        if not unfulfilled then
            local questName = C_QuestLog.GetQuestInfo(questID)

            DualBoxer.DebugPrint(format("Quest %s is complete.", questName))

            local data = {
                messageType = "QUEST_UPDATE",
                id = questID,
                name = questName,
                status = "complete"
            }

            DualBoxer:SendMessage(Wolf_Utilities:Serialize(data))
        end
    end)
end

function DualBoxer:QuestAccepted(questID)
    DualBoxer.DebugPrint(format("Quest ID %s Accepted.", questID))

    if DualBoxer:FindApprovedMemberUnit() ~= nil then
        if C_QuestLog.IsPushableQuest ~= nil then
            if C_QuestLog.IsPushableQuest(questID) then
                DualBoxer:PushQuest(questID)
            else
                -- TODO: Push warning.
            end
        else
            DualBoxer:PushQuest_Classic(questID)
        end
    else
        DualBoxer.DebugPrint("Not in DualBoxer mode.")
    end
end

function DualBoxer:PushQuest(questID)
    C_QuestLog.SetSelectedQuest(questID)

    if C_QuestLog.GetSelectedQuest() == questID then
        QuestLogPushQuest()
    end
end

function DualBoxer:PushQuest_Classic(questID)
    local logIndex = GetQuestLogIndexByID(questID)

    if logIndex > 0 then
        SelectQuestLogEntry(logIndex)

        if GetQuestLogPushable() then
            DualBoxer.DebugPrint(format("Pushing quest index %s", logIndex))
            QuestLogPushQuest()
        else
            DualBoxer.DebugPrint(format("Quest %s is not shareable.", questID))
        end
    else
        DualBoxer.DebugPrint(format("Accepted ID %s but not in log.", questID))
    end
end

function DualBoxer:ProcessQuesUpdateMessage(sender, message)
    if message.status == "complete" then
        print(C_ColorUtil.WrapTextInColorCode(
            format("%s completed '%s'", sender, message.name),
            "ff00ff00")
        )
    else
        print(format("Unknown Quest Message from %s : %s", sender, Wolf_Utilities:TableToString(message)))
    end
end
