---@diagnostic disable: duplicate-set-field
function DualBoxer:PushQuest(questID)
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

function DualBoxer:SendQuestComplete(questID)
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

function DualBoxer:QuestWatchUpdate(questID)
    C_Timer.After(3,
        function()
            DualBoxer:QuestUpdate(questID)
        end
    )
end

function DualBoxer:QuestLogUpdate()

end
