function DualBoxer:QuestUpdate(questID)
    DualBoxer.DebugPrint(format("Quest ID %s updated.", questID))

    local objectives = C_QuestLog.GetQuestObjectives(questID)
    local unfulfilled = false

    for i, objective in ipairs(objectives) do
        if objective ~= nil and objective.finished == false then
            DualBoxer.DebugPrint(format("Quest ID %s has unfulfilled objective. %s", questID, objective.text))
            unfulfilled = true
        end
    end

    if not unfulfilled then
        DualBoxer.DebugPrint(format("Quest ID %s is complete.", questID))
        DualBoxer:SendQuestComplete(questID)
        DualBoxer.QuestsWatched[questID] = nil
    end
end

function DualBoxer:QuestAccepted(questID)
    DualBoxer.DebugPrint(format("Quest ID %s Accepted.", questID))

    if (DualBoxer:FindApprovedMemberUnit() ~= nil) and (not DualBoxer_Settings.Follower) then
        DualBoxer:PushQuest(questID)
    else
        DualBoxer.DebugPrint("Not in DualBoxer mode.")
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
