function DualBoxer:SendQuestComplete(questID)
    local questName = C_QuestLog.GetTitleForQuestID(questID)

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
    DualBoxer.DebugPrint(format("Adding watch for quest %s.", questID))
    DualBoxer.QuestsWatched[questID] = true

    C_QuestLog.RequestLoadQuestByID(questID)
end

function DualBoxer:PushQuest(questID)
    if C_QuestLog.IsPushableQuest(questID) then
        C_QuestLog.SetSelectedQuest(questID)

        if C_QuestLog.GetSelectedQuest() == questID then
            QuestLogPushQuest()
        end
    else
        local questName = C_QuestLog.GetTitleForQuestID(questID)

        print(C_ColorUtil.WrapTextInColorCode(
            format("%s cannot be shared'", questName),
            "ffff0000")
        )

        local willPlay = PlaySound(29055, "SFX", false)

        if not willPlay then
            print("Failed to play sound.")
        end
    end
end

function DualBoxer:QuestLogUpdate()
    DualBoxer.DebugPrint(
        format(
            "Watching Quests %s",
            Wolf_Utilities:TableToString(DualBoxer.QuestsWatched)
        )
    )

    for key, value in pairs(DualBoxer.QuestsWatched) do
        if value then
            DualBoxer.DebugPrint(format("Checking watched quest %s.", key))
            DualBoxer:QuestUpdate(key)
        end
    end
end
